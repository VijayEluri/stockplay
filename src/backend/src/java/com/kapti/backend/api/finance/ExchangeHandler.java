/*
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

package com.kapti.backend.api.finance;

import com.kapti.backend.api.MethodClass;
import com.kapti.data.Exchange;
import com.kapti.data.persistence.GenericDAO;
import com.kapti.exceptions.StockPlayException;
import com.kapti.filter.Filter;
import com.kapti.filter.parsing.Parser;
import java.util.Collection;
import java.util.HashMap;
import java.util.Vector;

/**
 * \brief   Handler van de Finance.Exchange subklasse.
 *
 * Deze klasse is de handler van de Finance.Exchange subklasse. Ze staat in
 * voor de verwerking van aanroepen van functies die zich in deze klasse
 * bevinden, lokaal de correcte aanvragen uit te voeren, en het resultaat
 * op conforme wijze terug te sturen.
 */
public class ExchangeHandler extends MethodClass {
    //
    // Methodes
    //

    public Vector<HashMap<String, Object>> List() throws StockPlayException {
        // Get DAO reference
        GenericDAO<com.kapti.data.Exchange, String> exDAO = getDAO().getExchangeDAO();

        // Fetch and convert all exchanges
        Collection<com.kapti.data.Exchange> tExchanges = exDAO.findAll();
        Vector<HashMap<String, Object>> oVector = new Vector<HashMap<String, Object>>();
        for (com.kapti.data.Exchange tExchange : tExchanges) {
            oVector.add(tExchange.toStruct(
                    com.kapti.data.Exchange.Fields.SYMBOL,
                    com.kapti.data.Exchange.Fields.NAME,
                    com.kapti.data.Exchange.Fields.LOCATION));
        }

        return oVector;
    }



    public Vector<HashMap<String, Object>> List(String iFilter) throws StockPlayException {
        // Get DAO reference
        GenericDAO<com.kapti.data.Exchange, String> exDAO = getDAO().getExchangeDAO();

        Parser parser = Parser.getInstance();
        Filter filter = parser.parse(iFilter);

        // Fetch and convert all exchanges
        Collection<com.kapti.data.Exchange> tExchanges = exDAO.findByFilter(filter);
        Vector<HashMap<String, Object>> oVector = new Vector<HashMap<String, Object>>();
        for (com.kapti.data.Exchange tExchange : tExchanges) {
            oVector.add(tExchange.toStruct(
                    com.kapti.data.Exchange.Fields.SYMBOL,
                    com.kapti.data.Exchange.Fields.NAME,
                    com.kapti.data.Exchange.Fields.LOCATION));
        }

        return oVector;
    }

    public int Modify(String iFilter, HashMap<String, Object> iDetails) throws StockPlayException {
        // Get DAO reference
        GenericDAO<com.kapti.data.Exchange, String> exDAO = getDAO().getExchangeDAO();

        Parser parser = Parser.getInstance();
        Filter filter = parser.parse(iFilter);

        // Get the exchanges we need to modify
        Collection<com.kapti.data.Exchange> tExchanges = exDAO.findByFilter(filter);

        // Now apply the new properties
        for (com.kapti.data.Exchange tExchange : tExchanges) {
            tExchange.applyStruct(iDetails);
            exDAO.update(tExchange);
        }

        return 1;
    }
    
    public int Create(HashMap<String, Object> iDetails) throws StockPlayException {
        // Get DAO reference
        GenericDAO<com.kapti.data.Exchange, String> exDAO = getDAO().getExchangeDAO();

        // Instantiate a new exchange
        Exchange tExchange = Exchange.fromStruct(iDetails);

        tExchange.applyStruct(iDetails);
        exDAO.create(tExchange);

        return 1;
    }
}