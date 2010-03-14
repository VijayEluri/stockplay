/*
 * ConcreteDummy.java
 * StockPlay - Dummy implementatie van de Finance.Security subklasse.
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
package com.kapti.backend.api.finance.security;

import com.kapti.backend.api.finance.Security;
import com.kapti.data.persistence.GenericDAO;
import com.kapti.exceptions.StockPlayException;
import java.util.Collection;
import java.util.Hashtable;
import java.util.Vector;
import org.apache.xmlrpc.XmlRpcException;

/**
 * \brief   Dummy implementatie van de Finance.Security interface.
 *
 * Deze klasse is een dummy implementatie van de Finance.Security interface. Een
 * dergelijke implementatie geeft valide data terug, zonder daarvoor de database
 * te raadplegen. Deze implementatie kan zo gebruikt worden om een client-systeem
 * te testen.
 */
public class ConcreteDatabase extends Security {
    //
    // Methodes
    //

    @Override
    public Vector<Hashtable<String, Object>> List(String iFilter) throws XmlRpcException, StockPlayException {
        // Get DAO reference
        GenericDAO<com.kapti.data.Security, String> tSecurityDAO = getDAO().getSecurityDAO();

        // Fetch and convert all Indexs
        Collection<com.kapti.data.Security> tIndexs = tSecurityDAO.findAll();
        Vector<Hashtable<String, Object>> oVector = new Vector<Hashtable<String, Object>>();
        for (com.kapti.data.Security tIndex : tIndexs) {
            oVector.add(tIndex.toStruct(
                    com.kapti.data.Security.Fields.ID,
                    com.kapti.data.Security.Fields.NAME,
                    com.kapti.data.Security.Fields.EXCHANGE));
        }

        return oVector;
    }

    @Override
    public int Modify(String iFilter, Hashtable<String, Object> iDetails) throws XmlRpcException, StockPlayException {
        // Get DAO reference
        GenericDAO<com.kapti.data.Security, String> tSecurityDAO = getDAO().getSecurityDAO();

        // Get the Indexs we need to modify
        Collection<com.kapti.data.Security> tIndexs = tSecurityDAO.findAll();

        // Now apply the new properties
        // TODO: controleren of de struct geen ID field bevat, deze kan _enkel_
        //       gebruikt worden om een initiële Exchange aa nte maken (Create)
        for (com.kapti.data.Security tIndex : tIndexs) {
            tIndex.fromStruct(iDetails);
            tSecurityDAO.update(tIndex);
        }

        return 1;
    }

    @Override
    public int Create(Hashtable<String, Object> iDetails) throws XmlRpcException, StockPlayException {
        // Get DAO reference
        GenericDAO<com.kapti.data.Security, String> tSecurityDAO = getDAO().getSecurityDAO();

        // Get the Indexs we need to modify
        Collection<com.kapti.data.Security> tIndexs = tSecurityDAO.findAll();

        // Now apply the new properties
        for (com.kapti.data.Security tIndex : tIndexs) {
            tIndex.fromStruct(iDetails);
            tSecurityDAO.create(tIndex);
        }

        return 1;
    }

    @Override
    public Vector<Hashtable<String, Object>> Details(String iFilter) throws XmlRpcException, StockPlayException {
        // TODO: welke dingen worden hier _meer_ getoond? Als enkel Quotes, moeten we hier
        //       geen aparte klasse voor maken? Quotes.List(met key SECURITY)?
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public int Update(Hashtable<String, Object> iDetails) throws XmlRpcException, StockPlayException {
        // TODO: zie ook hierboven, extra klasse aanmaken of niet?
        throw new UnsupportedOperationException("Not supported yet.");
    }

}

