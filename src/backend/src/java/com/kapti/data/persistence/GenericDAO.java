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

package com.kapti.data.persistence;

import com.kapti.cache.Annotations.Cachable;
import com.kapti.cache.Annotations.Invalidates;
import com.kapti.exceptions.FilterException;
import com.kapti.exceptions.StockPlayException;
import com.kapti.filter.Filter;
import java.util.Collection;

public interface GenericDAO<T, ID> {
    //
    // Methods
    //

    public @Cachable T findById(ID id) throws StockPlayException;
    public @Cachable Collection<T> findByFilter(Filter iFilter) throws StockPlayException, FilterException;
    public @Cachable Collection<T> findAll() throws StockPlayException;

    public @Invalidates boolean update(T entity) throws StockPlayException;
    public @Invalidates int create(T entity) throws StockPlayException;
    public @Invalidates boolean delete(T entity) throws StockPlayException;
}