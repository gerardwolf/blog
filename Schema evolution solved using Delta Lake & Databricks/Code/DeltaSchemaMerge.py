# Compare source and sink data frame schemas

dfSourceSchema = dfSource.schema.fields
dfSinkSchema = dfSink.schema.fields
if dfSourceSchema == dfSinkSchema:
  print("Source and Sink schemas match")
  shemasMatch = 1
  #print(shemasMatch)
else:
  print("Source and Sink schemas do not match")
  shemasMatch = 0
  #print(shemasMatch)  

# Merge source and sink schemas if not matched

from pyspark.sql.functions import lit

if shemasMatch == 0:
  dfSourceNames = [x.name.lower() for x in dfSourceSchema]
  dfSinkNames = [x.name.lower() for x in dfSinkSchema]
  colDiffAdd = list(set(dfSourceNames) - set(dfSinkNames))
  if len(colDiffAdd) != 0:
    structList = [(x.name,x.dataType) for x in dfSourceSchema if (x.name.lower() in colDiffAdd)]
    dfMergedSchema = dfSink.where("1=0") # Create empty dataframe to merge Sink schema
    for i in structList:
      dfMergedSchema = dfMergedSchema.withColumn(i[0],lit(None).cast(i[1]))
    print("Merging Sink Delta Lake schema")
    # Merge the Sink schema
    dfMergedSchema.write.option("mergeSchema","true").mode("append").format("delta").save(persistedMountPath)
    #  Refresh the dfSink dataframe with latest schema
    spark.sql("""REFRESH TABLE {DATABASE}.{TABLE}""".format(DATABASE=persistedDatabase,TABLE=persistedTable))    
    dfSink= spark.sql("SELECT * FROM {DATABASE}.{TABLE} WHERE 1=1 {FILTER}".format(DATABASE=persistedDatabase,TABLE=persistedTable,PATH=persistedMountPath,FILTER=reduce))
    #dfMergedSchema.show()
  colDiffRemove = list(set(dfSinkNames) - set(dfSourceNames))
  if len(colDiffRemove) != 0:
    structList = [(x.name,x.dataType) for x in dfSinkSchema if (x.name.lower() in colDiffRemove)]
    print("Merging Source schema")
    for i in structList:
      dfSource = dfSource.withColumn(i[0],lit(None).cast(i[1]))
    # Refresh source temp view schema
    dfSource.createOrReplaceTempView(transientView)
    #dfSource.show()
