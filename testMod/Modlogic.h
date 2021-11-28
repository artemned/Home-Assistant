#pragma once

#include <string>
#include <iostream>
#include <QTcpSocket>
#include "modbus_exception.h"
#include <cstdint>
#include <cstring>
#include <QDataStream>
#include <QTimer>



#define MAX_MSG_LENGTH 260

//Function Code
enum {
    READ_REGS = 0x03,
    WRITE_COIL = 0x05,
    WRITE_REG = 0x06,
};

//Exception Codes
enum {
    EX_ILLEGAL_FUNCTION = 0x01, // Function Code not Supported
    EX_ILLEGAL_ADDRESS = 0x02, // Output Address not exists
    EX_ILLEGAL_VALUE = 0x03, // Output Value not in Range
    EX_SERVER_FAILURE = 0x04, // Slave Deive Fails to process request
    EX_ACKNOWLEDGE = 0x05, // Service Need Long Time to Execute
    EX_SERVER_BUSY = 0x06, // Server Was Unable to Accept MB Request PDU
    EX_GATEWAY_PROBLEMP = 0x0A, // Gateway Path not Available
    EX_SLAVE_PROBLEM = 0x0B, // Target Device Failed to Response
};



class modbus : public QObject {


    Q_OBJECT


private:
//////////////////////////////////member clasess for connection//////////////////////////////////////////////

    bool connected_=false;
    uint16_t msg_id_;
    uint16_t slaveid_;
    std::string host_="";
    uint16_t port_ =502;
    uint8_t address_error_registr_;
    uint8_t function_code_;

/////////////////////////////////fabricate requests/////////////////////////////////////////

    void modbus_build_request(uint8_t* to_send, int address, int func);
    void modbus_read(int address, int amount, int func);
    void modbus_write(int address,int func, uint16_t* value);
    size_t modbus_send(uint8_t* to_send, int length);
    size_t modbus_receive(uint8_t* buffer);
    void modbus_error_handle(const vector<uint8_t>& msg);
    void query_filter(const std::vector<uint8_t>& requestResponse);
    void read_regist(const std::vector<uint8_t>& range);

//////////////////////////////////////////////////////////////////////////////////

private slots:

    void connected();
    void connectionTimeout();

public slots:

    void closeConnection();
    void connect2host(std::string host, uint16_t port,uint16_t slaveId);
    void beginReciev();

signals:

    void signalReadHoldings(const std::vector<uint16_t>& range);
    void statusChanged(bool);
    void modbusError(int addReg,QString modbus_error);
    void signalWriteCoil(bool t,int number);
    void signalWrittenRegistr(int address,int number);

public:

    modbus();
    virtual ~modbus();
    void modbus_close();    
    bool get_connect()const;
    void modbus_set_slave_id(uint16_t id);

    struct requestStatus{

        bool coilStatus=false;
        bool writenRegistr=false;
        vector<uint16_t> rangeHoldings;

    }requestStatus;

    ///////////////////////////////send requests////////////////////////////////////

    void modbus_read_holding_registers(uint16_t address,int amount);// int16_t* buffer);
    void modbus_write_coil(uint16_t address, bool to_write);
    void modbus_write_register(uint16_t address, uint16_t value);

    ////////////////////////////member class/////////////////////////////////////////////////////////

    QTcpSocket *tcp_socket;
    QTimer *timeout_timer;

    ////////////////////////////////////////////////////////////////////////////////////////////
};





