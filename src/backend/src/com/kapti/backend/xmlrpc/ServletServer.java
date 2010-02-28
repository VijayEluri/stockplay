/*
 * ServletServer.java
 * StockPlay - Uitbreiding van de standaard ServletServer.
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
package com.kapti.backend.xmlrpc;

import org.apache.xmlrpc.XmlRpcException;
import org.apache.xmlrpc.XmlRpcRequest;
import org.apache.xmlrpc.webserver.XmlRpcServletServer;
import com.kapti.backend.api.Error;
import org.apache.log4j.Logger;

/**
 * \brief Uitbreiding van de standaard ServletServer.
 *
 * Custom XML-RPC servlet server, dewelke de execute() functie van de
 * onderliggende XmlRpcServer klasse overschrijft. Dit om excepties die niet
 * door onszelf gegenereerd zijn, te trappen en het teveel aan informatie dat
 * er standaard in zit te verwijderen (lijnnummers, foutdetails, etc).
 */
public class ServletServer extends XmlRpcServletServer {
    //
    // Data members
    //

    static Logger mLogger = Logger.getLogger(ServletServer.class);


    //
    // Methods
    //

    /**
     * Overschrijven van de execute() methode in de onderliggende klasse
     * XmlRpcServer. Dit om gegenereerde Extenties op te vangen en eventueel
     * te filteren/transformeren vooraleer ze naar een hogerliggende laag
     * door te sturen.
     */
    @Override
    public Object execute(XmlRpcRequest iRequest) throws XmlRpcException {
        try {
            return super.execute(iRequest);
        } catch (XmlRpcException iException) {
            // Was the exception generated by our code?
            if (iException.code == 0) {
                // Log the original message
                final String tMessage = iException.getMessage();
                mLogger.error("untrapped exception (" + tMessage + ")");
                
                // Detect exception subtype
                if (tMessage.contains("No method matching arguments")) {
                    throw Error.BAD_REQUEST.getException();
                }
                else if (tMessage.contains("No such handler")) {
                    throw Error.NOT_FOUND.getException();
                }

                // No exception subtype matched, throw an internal failure
                throw Error.INTERNAL_FAILURE.getException();
            } else {
                throw iException;
            }
        }
    }

}
