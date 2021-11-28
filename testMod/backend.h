#pragma once

#include <QObject>
#include "Modlogic.h"

class backend:public QObject
{

    Q_OBJECT
    Q_PROPERTY(bool currentStatus READ get_status NOTIFY statusChanged)



public:

    explicit backend(QObject *parent = nullptr);

    bool get_status();

signals:

    void someError(int addReg, QString err);
    void statusChanged(QString newStatus);
    void statusCoil(bool status,int number);
    void statusReg(int addressReg,int valueReg);
    void statusHoldingsReg(const std::vector<qreal> range);

public slots:

    void setStatus(bool newStatus);
    void gotError(QAbstractSocket::SocketError err);
    void gotErrorModbus(int addReg,QString modbus_error);
    void connectClicked(QString host, int port,int slaveId);
    void disconnectClicked();
    void slotWrittenCoil(bool stateCoil,int number);
    void slotWrittenRegistr(int address,int number);
    void slotReadHoldings(const std::vector<uint16_t>& range);


//////////////Function for writing///////////////////////////

    void writeCoil(int adress,bool state);
    void writeReg(int address, int value);

/////////////Function for reading////////////////////////////////////////////////

    bool readReg(int address,int count);

////////////////////////////////////////////////////////////////////////////////////



private:

   float& combain_data(const std::vector<uint16_t>& source);

   modbus* client;


};

