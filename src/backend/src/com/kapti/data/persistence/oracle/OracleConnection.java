/*
 * OracleConnectionDAO.java
 * StockPlay - Verbinding met de Oracle database
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

package com.kapti.data.persistence.oracle;

import org.apache.commons.dbcp.BasicDataSource;

import com.kapti.exceptions.*;
import java.sql.*;

public class OracleConnection {

    public static BasicDataSource ds = null;

    public static Connection getConnection() throws DBException {
        try {
            if (ds == null) {

                ds = new BasicDataSource();
                ds.setDriverClassName("oracle.jdbc.driver.OracleDriver");

                //ds.setUrl("jdbc:oracle:thin:@//oersted.iii.hogent.be:1521/xe");
                ds.setUrl("jdbc:oracle:thin:@//be01.kapti.com:1521/xe");
                
                ds.setUsername("stockplay");
                ds.setPassword("chocolademousse");
            }

            return ds.getConnection();
        } catch (SQLException ex) {
            throw new DBException("Error while creating connection-object", ex);
        }
    }
}
