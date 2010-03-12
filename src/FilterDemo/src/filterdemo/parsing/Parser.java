/*
 * Parser.java
 * StockPlay - Parser voor string-filter conversie.
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
package filterdemo.parsing;

import filterdemo.Filter;
import filterdemo.data.Data;
import filterdemo.data.DataFloat;
import filterdemo.data.DataInt;
import filterdemo.data.DataKey;
import filterdemo.data.DataString;
import filterdemo.exception.ParserException;
import filterdemo.exception.TokenizerException;
import filterdemo.relation.Relation;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.locks.Condition;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author tim
 */
public class Parser {
    //
    // Member data
    //

    public static enum Type {
        INT, FLOAT,
        WORD, QUOTE,
        PARAM_OPEN, PARAM_CLOSE,
        WHITESPACE
    }

    private List<Rule> mRules;


    //
    // Construction
    //

    public Parser() {
        mRules = new ArrayList<Rule>();
        mRules.add(new Rule(Type.INT, "[0-9]+"));
        mRules.add(new Rule(Type.FLOAT, "[0-9.]+"));
        mRules.add(new Rule(Type.WORD, "[A-Za-z_]+"));
        mRules.add(new Rule(Type.QUOTE, "\"([^\"]*+)\""));
        mRules.add(new Rule(Type.PARAM_OPEN, "\\("));
        mRules.add(new Rule(Type.PARAM_CLOSE, "\\)"));
        mRules.add(new Rule(Type.WHITESPACE, "\\s+"));
    }


    //
    // Methods
    //

    // Main method
    public Filter parse(String iSource) throws ParserException, TokenizerException {
        // Lexical analysis
        List<Token> result = tokenize(iSource);
        System.out.println("Parsed tokens: ");
        for (Token tToken : result) {
            System.out.println(tToken + ": " + tToken.getContent());
        }

        // Syntactic analysis
        Filter oFilter = interprete(result.iterator());

        return oFilter;
    }

    // Lexical analysis: the tokenizer
    List<Token> tokenize(String iSource) throws TokenizerException {
        // Setup
        int tPosition = 0;
        final int tEnd = iSource.length();
        List<Token> oTokens = new ArrayList<Token>();

        // Create a new matcher container
        Matcher tMatcher = Pattern.compile("dummy").matcher(iSource);
        tMatcher.useTransparentBounds(true).useAnchoringBounds(false);

        // Walk the string
        while (tPosition < tEnd) {
            tMatcher.region(tPosition, tEnd);

            // Check all rules
            List<Token> tMatches = new ArrayList<Token>();
            for (Rule tRule : mRules) {
                if (tMatcher.usePattern(tRule.getPattern()).lookingAt()) {
                    // Fetch the relevant content
                    String tContent = null;
                    int tGroup = tMatcher.groupCount();
                    if (tGroup > 1) {
                        throw new TokenizerException("found multiple matching groups within rule");
                    }
                    tContent = iSource.substring(tMatcher.start(tGroup), tMatcher.end(tGroup));

                    tMatches.add(new Token(tRule.getType(), tMatcher.start(), tMatcher.end(), tContent));
                }
            }

            // Pick the longest match
            Token tTokenLongest = null;
            for (Token tToken : tMatches) {
                if (tTokenLongest == null || tToken.getLength() > tTokenLongest.getLength()) {
                    tTokenLongest = tToken;
                }
            }
            if (tTokenLongest != null) {
                oTokens.add(tTokenLongest);
                tPosition = tTokenLongest.getEnd();
            } else
                tPosition++;    // TODO: warn, as we couldn't match anything?
        }
        return oTokens;
    }

    // Syntactic analysis: the interpreter
    public Filter interprete(Iterator<Token> iIterator) throws ParserException {
        Filter oFilter = new Filter();

        // State
        Token tToken;
        Relation tRelation;
        Condition tCondition;
        List<Data> tParameters = null;

        // Process the tokens
        while (iIterator.hasNext()) {
            tToken = iIterator.next();

            switch (tToken.getType()) {
                case INT: {
                    if (tParameters == null)
                        throw new ParserException("found raw integer out of parameter scope");
                    tParameters.add(new DataInt(Integer.parseInt(tToken.getContent())));

                    break;
                }
                case FLOAT: {
                    if (tParameters == null)
                        throw new ParserException("found raw float out of parameter scope");
                    tParameters.add(new DataFloat(Double.parseDouble(tToken.getContent())));

                    break;
                }
                case QUOTE: {
                    if (tParameters == null)
                        throw new ParserException("found unknown quoted string out of parameter scope");
                    if (tParameters.size() == 0)
                        tParameters.add(new DataString(tToken.getContent()));
                    else    // TODO: keys are LVALUE
                        tParameters.add(new DataKey(tToken.getContent()));

                    break;
                }
                case WORD: {
                    // Check if word is a routine
                    if (true) {

                    }

                    break;
                }
                case PARAM_OPEN: {
                    tParameters = new ArrayList();

                    break;
                }
                case PARAM_CLOSE: {
                    tParameters = null;

                    break;
                }
                case WHITESPACE: {


                    break;
                }
                default: {
                    throw new ParserException("unknown token");
                }
            }
        }

        return oFilter;
    }
}
