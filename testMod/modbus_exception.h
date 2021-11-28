#pragma once
#ifndef MODBUS_EXCEPTION_H_INCLUDED
#define MODBUS_EXCEPTION_H_INCLUDED

#include <exception>
#include <string>
using namespace std;


/**
 * MODBS EXCPETION
 */
class modbus_exception : public exception {
public:
    string msg;
    virtual const char* what() const throw()
    {
        return "This is Error In Modbus Happened!";
    }
};


/**
 * Represent Connection Issue in Class
 */
class modbus_connect_exception : public modbus_exception {
public:
    virtual const char* what() const throw()
    {
        return "Having Modbus Connection Problem";
    }
};


/**
 * Illegal Function      Error response Function 0x01
 */
class modbus_illegal_function_exception : public modbus_exception {
public:
    virtual const char* what() const throw()
    {
        return "Illegal Function";
    }
};


/**
 * Illegal Address      Error Response Function 0x02
 */
class modbus_illegal_address_exception : public modbus_exception {
public:
    string msg = "test";
    const char* what() const throw()
    {
        return "Illegal address.";
    }
};


/**
 * Illegal Data Vlaue   Error Response Funciton 0x03
 */
class modbus_illegal_data_value_exception : public modbus_exception {
public:
    virtual const char* what() const throw()
    {
        return "Illegal data value.";
    }
};


/**
 * Server Failure       Error Response Function 0x04
 */
class modbus_server_failure_exception : public modbus_exception {
public:
    virtual const char* what() const throw()
    {
        return "Server failure.";
    }
};


/**
 * Acknowledge          Error Response Function 0x05
 */
class modbus_acknowledge_exception : public modbus_exception {
public:
    virtual const char* what() const throw()
    {
        return "Acknowledge.";
    }
};



/**
 * Server Busy           Error Response Function 0x06
 */
class modbus_server_busy_exception : public modbus_exception {
public:
    virtual const char* what() const throw()
    {
        return "Server busy.";
    }
};


/**
 * Gate Way Problem     Error Response Function 0x0A 0x0B
 */
class modbus_gateway_exception : public modbus_exception {
public:
    virtual const char* what() const throw()
    {
        return "Gateway problem.";
    }
};


class modbus_slave_exception : public modbus_exception {
public:
    virtual const char* what() const throw()
    {
        return "Slave is offline or does not exist.";
    }
};


/**
 * Buffer Exception
 * Buffer is Too Small for Data Storage
 */
class modbus_buffer_exception : public modbus_exception {
public:
    virtual const char* what() const throw()
    {
        return "Size of buffer is too small.";
    }
};


/**
 * Amount Exception
 * Address or Amount Input is Wrong
 */
class modbus_amount_exception : public modbus_exception {
public:
    virtual const char* what() const throw()
    {
        return "Too many data.";
    }
};



#endif // MODBUS_EXCEPTION_H_INCLUDED


