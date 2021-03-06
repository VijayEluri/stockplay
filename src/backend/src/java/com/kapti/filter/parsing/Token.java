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
package com.kapti.filter.parsing;

import java.util.List;

/**
 *
 * @author tim
 */
public class Token {
    //
    // Member data
    //

    private final Parser.TokenType mType;
    private final int mStart, mEnd;
    private final String mContent;
    private final List<String> mExtra;


    //
    // Construction
    //

    Token(Parser.TokenType iType, int iStart, int iEnd, String iContent) {
        this(iType, iStart, iEnd, iContent, null);
    }

    Token(Parser.TokenType iType, int iStart, int iEnd, String iContent, List<String> iExtra) {
        mType = iType;
        mStart = iStart;
        mEnd = iEnd;
        mContent = iContent;
        mExtra = iExtra;
    }


    //
    // Methods
    //

    @Override
    public String toString() {
        return String.format("Token [%2d, %2d, %s]: %s", mStart, mEnd, mType, getContent());
    }

    public Parser.TokenType getType() {
        return mType;
    }

    public int getStart() {
        return mStart;
    }
    
    public int getEnd() {
        return mEnd;
    }

    public int getLength() {
        return mEnd - mStart;
    }

    public String getContent() {
        return mContent;
    }

    public int getContentLength() {
        return mContent.length();
    }

    public List<String> getExtra() {
        return mExtra;
    }
}
