/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.kapti.data.persistence;

import com.kapti.data.*;

/**
 *
 * @author Thijs
 */
public interface StockPlayDAO {

    public GenericDAO<Exchange, String> getExchangeDAO();

    public GenericDAO<Index, Integer> getIndexDAO();

    public GenericDAO<Order, Integer> getOrderDAO();

    public GenericDAO<Quote, Quote.QuotePK> getQuoteDAO();

    public GenericDAO<Security, String> getSecurityDAO();

    public GenericDAO<Transaction, Integer> getTransactionDAO();

    public GenericDAO<User, Integer> getUserDAO();

    public GenericDAO<IndexSecurity, IndexSecurity> getIndexSecurityDAO();

    public GenericDAO<UserSecurity, UserSecurity.UserSecurityPK> getUserSecurityDAO();
}