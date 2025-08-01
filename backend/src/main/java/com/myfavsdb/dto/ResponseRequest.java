package com.myfavsdb.dto;

public class ResponseRequest {
    
    public String returnMsg;
    public int statusCode;
    
    public ResponseRequest() {}
    
    public ResponseRequest(String returnMsg, int statusCode) {
        this.returnMsg = returnMsg;
        this.statusCode = statusCode;
    }
    
    public static ResponseRequest success(String message) {
        return new ResponseRequest(message, 200);
    }
    
    public static ResponseRequest error(String message, int statusCode) {
        return new ResponseRequest(message, statusCode);
    }
} 