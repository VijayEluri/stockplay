﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;

public partial class SecuritiesOverview : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        DataView securitiesView;

        if (!IsPostBack)
        {
            IDataAccess data = DataAccess.GetInstance();

            DataTable securitiesTable = GenerateDataTable(data.GetSecuritiesList());
            Session["securitiesView"] = securitiesTable.DefaultView;
        }

        securitiesView = (DataView) Session["securitiesView"];

        SecuritiesGridview.DataSource = securitiesView;
        SecuritiesGridview.DataBind();
    }

    private DataTable GenerateDataTable(List<Security> securities)
    {
        DataTable securitiesTable = new DataTable("Securities");

        securitiesTable.Columns.Add("Isin");
        securitiesTable.Columns["Isin"].DataType = typeof(string);
        securitiesTable.Columns.Add("Symbol");
        securitiesTable.Columns["Symbol"].DataType = typeof(string);
        securitiesTable.Columns.Add("Name");
        securitiesTable.Columns["Name"].DataType = typeof(string);
        securitiesTable.Columns.Add("Exchange");
        securitiesTable.Columns["Exchange"].DataType = typeof(string);
        securitiesTable.Columns.Add("Quote");
        securitiesTable.Columns["Quote"].DataType = typeof(double);
        securitiesTable.Columns.Add("Change");
        securitiesTable.Columns["Change"].DataType = typeof(double);
        securitiesTable.Columns.Add("Date");
        securitiesTable.Columns["Date"].DataType = typeof(DateTime);

        foreach (Security security in securities)
        {
            DataRow row = securitiesTable.NewRow();
            row[0] = security.Isin;
            row[1] = security.Symbol;
            row[2] = security.Name;
            row[3] = security.Exchange.Name;
            row[5] = security.GetChange();

            Quote q = security.GetLatestQuote();

            if (q != null)
            {
                row[4] = q.Buy;
                row[6] = q.Time;
            }

            securitiesTable.Rows.Add(row);
        }

        return securitiesTable;
    }

    /* Sortering en paginering mogelijk maken zonder datasourcecontrol:
     * BRON: http://forums.asp.net/p/956540/1177923.aspx
     */
    private string ConvertSortDirectionToSql(SortDirection sortDirection)
    {
        string newSortDirection = String.Empty;

        switch (sortDirection)
        {
            case SortDirection.Ascending:
                newSortDirection = "ASC";
                break;

            case SortDirection.Descending:
                newSortDirection = "DESC";
                break;
        }

        return newSortDirection;
    }

    protected void SecuritiesGridview_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        SecuritiesGridview.PageIndex = e.NewPageIndex;
        SecuritiesGridview.DataBind();
    }

    protected void SecuritiesGridview_Sorting(object sender, GridViewSortEventArgs e)
    {
        DataView dataView = (DataView) Session["securitiesView"];

        if (dataView != null)
        {
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

            SecuritiesGridview.DataSource = dataView;
            SecuritiesGridview.DataBind();
        }
    }    

    //Zorgt ervoor dat de kleur en formaat van de tekst correct ingesteld wordt in de "Change" kolom
    //Ook wordt de kolom met de Isin nummers onzichtbaar gemaakt voor de gebruiker
    protected void SecuritiesGridview_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if(e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[0].Visible = false;

            //Opmaak Change kolom
            if(Convert.ToDouble(e.Row.Cells[4].Text) > 0)
            {
                e.Row.Cells[4].CssClass = "pos";
                e.Row.Cells[4].Text = "+" + e.Row.Cells[4].Text + "%";
            }
            else if(Convert.ToDouble(e.Row.Cells[4].Text) < 0)
            {
                e.Row.Cells[4].CssClass = "neg";
                e.Row.Cells[4].Text = e.Row.Cells[4].Text + "%";
            }
            else
                e.Row.Cells[4].Text = " " + e.Row.Cells[4].Text + "%";
        }

        if (e.Row.RowType == DataControlRowType.Header)
            e.Row.Cells[0].Visible = false;
    }
}
