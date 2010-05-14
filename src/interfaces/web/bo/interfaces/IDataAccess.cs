using System;
using System.Collections.ObjectModel;
using System.Collections.Generic;

namespace StockPlay
{
	public interface IDataAccess
	{
	    //Securities
	    List<ISecurity> GetSecuritiesList();
	    List<ISecurity> GetSecuritiesList(string searchterm);
	    List<ISecurity> GetSecurityByIsin(params string[] isin);
        List<ISecurity> GetSecuritiesFromExchange(string id);

        //Indexes
        //List<IIndex> GetIndexesByIsin(params string[] isin);
	
	    //Quotes
	    IQuote GetLatestQuoteFromSecurity(string isin);
	    List<IQuote> GetLatestQuotesFromSecurities(List<ISecurity> securities);
	    List<IQuote> GetDailyQuotesFromSecurity(string isin, DateTime minDate, DateTime maxDate);
	    List<IQuote> GetQuotesFromSecurity(string isin, DateTime iFrom, DateTime iTo);
        List<DateTime> GetRange(string isin);
	
	    //Exhanges
	    IExchange GetExchangeBySymbol(string symbol);
	    List<IExchange> GetExchanges(); //Deze methode wordt nergens gebruikt?
	
	    //Users
	    void CreateUser(int id, string nickname, string password, string email, bool isAdmin, string lastname, string firstname, DateTime regDate,
	                    long rrn, int points, double startAmount, double cash);
	    bool RemoveUser(string nickname, string sessionID, ISession sessionHandler);
	    bool UpdateUser(IUser user, string sessionID, ISession sessionHandler);
	    IUser GetUserByNickname(string nickname, string sessionID, ISession sessionHandler);
	    string ValidateUser(string nickname, string password); //Geeft de sessionID terug, deze is de lege string als validatie is mislukt
        void ResetPassword(string nickname, string newPassword);
	
	    //User Securities
	    List<IUserSecurity> GetUserSecurities(int id, string sessionID, ISession sessionHandler);
	
	    //Transactions
	    List<ITransaction> GetUserTransactions(int id, string sessionID, ISession sessionHandler);
	
	    //Orders
	    void CreateOrder(int userId, string isin, int amount, double price, double alternativeLimit, string type, string sessionID, ISession sessionHandler);
	    void CancelOrder(int orderId, string sessionID, ISession sessionHandler);
	    List<IOrder> GetUserOrders(int id, string sessionID, ISession sessionHandler);
	}

}