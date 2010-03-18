/*
 * ConcreteDummy.java
 * StockPlay - Concrete implementatie van de Finance.Exchange subklasse.
 *
 * Copyright (c) 2010 StockPlay development team
 * All rights reserved.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */
package com.kapti.backend.api.finance.exchange;

import com.kapti.data.persistence.GenericDAO;
import com.kapti.exceptions.StockPlayException;
import com.kapti.filter.Filter;
import com.kapti.filter.exception.FilterException;
import java.util.Collection;
import java.util.Hashtable;
import java.util.Vector;
import org.apache.xmlrpc.XmlRpcException;

/**
 * \brief   Dummy implementatie van de Finance.Exchange interface.
 *
 * Deze klasse is een concrete implementatie van de Finance.Exchange interface. Een
 * dergelijke implementatie geeft valide data terug, die uit de database gehaald werd
 */
public class ConcreteDatabase extends com.kapti.backend.api.finance.Exchange {
    //
    // Methodes
    //

    @Override
    public Vector<Hashtable<String, Object>> List(Filter iFilter) throws XmlRpcException, StockPlayException, FilterException {
        // Get DAO reference
        GenericDAO<com.kapti.data.Exchange, String> exDAO = getDAO().getExchangeDAO();

        // Fetch and convert all exchanges
        Collection<com.kapti.data.Exchange> tExchanges = exDAO.findByFilter(iFilter);
        Vector<Hashtable<String, Object>> oVector = new Vector<Hashtable<String, Object>>();
        for (com.kapti.data.Exchange tExchange : tExchanges) {
            oVector.add(tExchange.toStruct(
                    com.kapti.data.Exchange.Fields.ID,
                    com.kapti.data.Exchange.Fields.NAME,
                    com.kapti.data.Exchange.Fields.LOCATION));
        }

        return oVector;
    }

    @Override
    public int Modify(Filter iFilter, Hashtable<String, Object> iDetails) throws XmlRpcException, StockPlayException, FilterException {
        // Get DAO reference
        GenericDAO<com.kapti.data.Exchange, String> exDAO = getDAO().getExchangeDAO();

        // Get the exchanges we need to modify
        Collection<com.kapti.data.Exchange> tExchanges = exDAO.findByFilter(iFilter);

        // Now apply the new properties
        // TODO: controleren of de struct geen ID field bevat, deze kan _enkel_
        //       gebruikt worden om een initiële Exchange aa nte maken (Create)
        for (com.kapti.data.Exchange tExchange : tExchanges) {
            tExchange.fromStruct(iDetails);
            exDAO.update(tExchange);
        }

        return 1;
    }

    @Override
    public int Create(Hashtable<String, Object> iDetails) throws XmlRpcException, StockPlayException {
        // Get DAO reference
        GenericDAO<com.kapti.data.Exchange, String> exDAO = getDAO().getExchangeDAO();

        // Get the exchanges we need to modify
        Collection<com.kapti.data.Exchange> tExchanges = exDAO.findAll();

        // Now apply the new properties
        for (com.kapti.data.Exchange tExchange : tExchanges) {
            tExchange.fromStruct(iDetails);
            exDAO.create(tExchange);
        }

        return 1;
    }
}