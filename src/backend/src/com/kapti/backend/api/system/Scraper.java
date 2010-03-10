/*
 * Scraper.java
 * StockPlay - Abstracte klasse van de System.Scraper interface.
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
package com.kapti.backend.api.system;

import com.kapti.backend.api.MethodClass;
import java.util.Hashtable;
import org.apache.xmlrpc.XmlRpcException;

/**
 * \brief Abstracte klasse van de System.Scraper interface.
 *
 * Deze klasse voorziet in functiesignaturen zoals voorgeschreven in de
 * protocoldefinitie van de System.Scraper subklasse.
 */
public abstract class Scraper extends MethodClass {
    //
    // Methodes
    //

    public abstract int Status() throws XmlRpcException;
    public abstract Hashtable<String, Object> Stats() throws XmlRpcException;
    public abstract boolean Restart() throws XmlRpcException;
    public abstract boolean Stop() throws XmlRpcException;
}