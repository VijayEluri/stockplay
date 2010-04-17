/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.kapti.administration.bo.user;

import com.kapti.administration.bo.finance.FinanceFactory;
import com.kapti.administration.bo.finance.Security;
import com.kapti.exceptions.StockPlayException;
import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Level;
import org.apache.log4j.Logger;

/**
 *
 * @author Thijs
 */
public class Transaction {

    private static Logger logger = Logger.getLogger(Transaction.class);

    public static enum Fields {

        ID, USER, ISIN, AMOUNT, PRICE, TYPE, // Instruction.Fields
        TIME, COMMENTS
    }
    protected int id;
    public static final String PROP_ID = "id";

    /**
     * Get the value of id
     *
     * @return the value of id
     */
    public int getId() {
        return id;
    }

    void setId(int id) {
        this.id = id;
    }



    Transaction(int id) {
        this.id = id;
    }
    protected User user;
    public static final String PROP_USER = "user";

    /**
     * Get the value of user
     *
     * @return the value of user
     */
    public User getUser() {
        return user;
    }

    /**
     * Set the value of user
     *
     * @param user new value of user
     */
    public void setUser(User user) {
        User oldUser = this.user;
        this.user = user;
        propertyChangeSupport.firePropertyChange(PROP_USER, oldUser, user);
    }
    protected Date time;
    public static final String PROP_TIME = "time";

    /**
     * Get the value of time
     *
     * @return the value of time
     */
    public Date getTime() {
        return time;
    }

    /**
     * Set the value of time
     *
     * @param time new value of time
     */
    public void setTime(Date time) {
        Date oldTime = this.time;
        this.time = time;
        propertyChangeSupport.firePropertyChange(PROP_TIME, oldTime, time);
    }
    protected Security security;
    public static final String PROP_SECURITY = "security";

    /**
     * Get the value of security
     *
     * @return the value of security
     */
    public Security getSecurity() {
        return security;
    }

    /**
     * Set the value of security
     *
     * @param security new value of security
     */
    public void setSecurity(Security security) {
        Security oldSecurity = this.security;
        this.security = security;
        propertyChangeSupport.firePropertyChange(PROP_SECURITY, oldSecurity, security);
    }

    public enum Type {

        BUY,
        SELL
    }
    protected Type type;

    /**
     * Get the value of type
     *
     * @return the value of type
     */
    public Type getType() {
        return type;
    }

    /**
     * Set the value of type
     *
     * @param type new value of type
     */
    public void setType(Type type) {
        this.type = type;
    }
    protected int amount;
    public static final String PROP_AMOUNT = "amount";

    /**
     * Get the value of amount
     *
     * @return the value of amount
     */
    public int getAmount() {
        return amount;
    }

    /**
     * Set the value of amount
     *
     * @param amount new value of amount
     */
    public void setAmount(int amount) {
        int oldAmount = this.amount;
        this.amount = amount;
        propertyChangeSupport.firePropertyChange(PROP_AMOUNT, oldAmount, amount);
    }
    protected double price;
    public static final String PROP_PRICE = "price";

    /**
     * Get the value of price
     *
     * @return the value of price
     */
    public double getPrice() {
        return price;
    }

    /**
     * Set the value of price
     *
     * @param price new value of price
     */
    public void setPrice(double price) {
        double oldPrice = this.price;
        this.price = price;
        propertyChangeSupport.firePropertyChange(PROP_PRICE, oldPrice, price);
    }
    protected String comment;
    public static final String PROP_COMMENT = "comment";

    /**
     * Get the value of comment
     *
     * @return the value of comment
     */
    public String getComment() {
        return comment;
    }

    /**
     * Set the value of comment
     *
     * @param comment new value of comment
     */
    public void setComment(String comment) {
        String oldComment = this.comment;
        this.comment = comment;
        propertyChangeSupport.firePropertyChange(PROP_COMMENT, oldComment, comment);
    }
    private PropertyChangeSupport propertyChangeSupport = new PropertyChangeSupport(this);

    /**
     * Add PropertyChangeListener.
     *
     * @param listener
     */
    public void addPropertyChangeListener(PropertyChangeListener listener) {
        propertyChangeSupport.addPropertyChangeListener(listener);
    }

    /**
     * Remove PropertyChangeListener.
     *
     * @param listener
     */
    public void removePropertyChangeListener(PropertyChangeListener listener) {
        propertyChangeSupport.removePropertyChangeListener(listener);
    }

    public static Transaction fromStruct(HashMap h) {
        Transaction t = new Transaction((Integer) h.get(Fields.ID.toString()));
        try {
            t.setUser(UserFactory.getInstance().getUserById((Integer) h.get(Fields.USER.toString())));
        } catch (StockPlayException ex) {
            t.setUser(null);
            logger.error("Error while retrieving user for transaction " + t.getId(), ex);
        }

        try {
            t.setSecurity(FinanceFactory.getInstance().getSecurityById((String) h.get(Fields.ISIN.toString())));
        } catch (StockPlayException ex) {
            t.setSecurity(null);
            logger.error("Error while retrieven security for transaction " + t.getId(), ex);
        }

        t.setType(Type.valueOf((String) h.get(Fields.TYPE.toString())));
        t.setAmount((Integer) h.get(Fields.AMOUNT.toString()));
        t.setPrice((Double) h.get(Fields.PRICE.toString()));
        t.setComment((String) h.get(Fields.COMMENTS.toString()));

        return t;
    }

    public HashMap toStruct(){

        HashMap h = new HashMap();

        h.put(Fields.ID.toString(), getId());
        h.put(Fields.USER.toString(), getUser().getId());
        h.put(Fields.ISIN.toString(), getSecurity().getISIN());
        h.put(Fields.TYPE.toString(), getType().toString());
        h.put(Fields.TIME.toString(), getTime());
        h.put(Fields.AMOUNT.toString(), getAmount());
        h.put(Fields.PRICE.toString(), getPrice());
        h.put(Fields.COMMENTS.toString(), getComment());

        return h;


    }
}
