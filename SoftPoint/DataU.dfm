object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 321
  Width = 439
  object cDBCon: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Data Source= 127.0.0.1,1434;User=1;Initial C' +
      'atalog=one_base;'
    Provider = 'SQLOLEDB.1'
    Left = 32
    Top = 256
  end
  object aqTestObjects: TADOQuery
    CacheSize = 100
    Connection = cDBCon
    CursorLocation = clUseServer
    MaxRecords = 100
    Parameters = <>
    SQL.Strings = (
      
        'SELECT t.id, t.name, t.comment, ov.value1, ov.value2, ov.value3,' +
        ' ov.date_time'
      'FROM dbo.test_Object t'
      'left join dbo.test_ObjectValue ov on ov.obj_id = t.id  '
      'order by t.id')
    Left = 96
    Top = 256
  end
end
