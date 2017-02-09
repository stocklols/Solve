using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


public class DataTables
{
    #region Constructors
    public DataTables()
    {

    }

    public DataTables(List<string[]> convertList)
        : this()
    {
        this.RetDataTable = retDataTable;
    }

    public DataTables(List<string[]> convertList, DataTable retDataTable)
        : this()
    {
        this.ConvertList = convertList;
        this.RetDataTable = retDataTable;
    }

    public DataTables(int colCount, List<string[]> convertList) : this()
    {
        this.ColCount = colCount;
        this.ConvertList = convertList;
        this.RetDataTable = retDataTable;
    }
    #endregion


    #region Variables
    private string connectionString;
    public string ConnectionString
    {
        get { return connectionString; }
        set { connectionString = value; }
    }

    private string tableName;
    public string TableName
    {
        get { return tableName; }
        set { tableName = value; }
    }

    private List<string[]> convertList;
    public List<string[]> ConvertList
    {
        get { return convertList; }
        set { convertList = value; }
    }

    private DataTable retDataTable;
	public DataTable RetDataTable
	{
		get { return retDataTable;}
		set { retDataTable = value;}
	}

    private int colCount;
    public int ColCount
    {
        get { return colCount; }
        set { colCount = value; }
    }
    #endregion


    #region Methods
    public DataTable BuildDataTable(int colCount, List<string[]> convertList)
    {
        DataTable buildNewDataTable = new DataTable();

        for (int i = 0; i < colCount; i++)
        {
            Console.WriteLine(convertList[i][0] + ": " + convertList[i][1]);
            DataColumn genericColumn = new DataColumn();
            genericColumn.DataType = System.Type.GetType(convertList[i][0]);
            genericColumn.ColumnName = convertList[i][1];
            buildNewDataTable.Columns.Add(genericColumn);
            genericColumn.Dispose();
        }

        return buildNewDataTable;
    }


    public DataTable ConvertStringListToDataTable(List<string[]> convertList)
    {
        DataTable returnDataTable = new DataTable();
        int colNumber = 0;
        
        foreach (var array in convertList)
        {
            if (array.Length > colNumber)
            {
                colNumber = array.Length;
            }
        }

        for (int i = 0; i < colNumber; i++)
        {
            returnDataTable.Columns.Add();
        }

        foreach (var array in convertList)
        {
            returnDataTable.Rows.Add(array);
        }

        return returnDataTable;
    }

    public void CopyDataTable(DataTable copyDataTable, string tableName)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["mySql"].ConnectionString;
        SqlConnection scon = new SqlConnection(connectionString);
        
        using (SqlBulkCopy copyDt = new SqlBulkCopy(scon))
        {
            scon.Open();

            try
            {
                copyDt.DestinationTableName = tableName;
                copyDt.WriteToServer(copyDataTable);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Failed to bulk copy data table.  Details: " + ex.Message);
            }
            finally
            {
                scon.Dispose();
                copyDt.Close();
            }
        }
    }
    #endregion
}
