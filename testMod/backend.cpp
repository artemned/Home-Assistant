
#include "backend.h"
#include <sstream>

backend::backend(QObject *parent) : QObject(parent)
{

  client = new modbus();

  connect(client, &modbus::statusChanged, this, &backend::setStatus);
  connect(client,&modbus::signalWriteCoil,this,&backend::slotWrittenCoil);
  connect(client,&modbus::signalWrittenRegistr,this,&backend::slotWrittenRegistr);
  connect(client,&modbus::signalReadHoldings,this,&backend::slotReadHoldings);
  connect(client,&modbus::modbusError,this,&backend::gotErrorModbus);
  connect(client->tcp_socket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(gotError(QAbstractSocket::SocketError)));

}

bool backend::get_status()
{
    return client->get_connect();

}

void backend::setStatus(bool newStatus)
{

    //qDebug() << "new status is:" << newStatus;
    if (newStatus)
        { emit statusChanged("CONNECTED"); }
    else
        { emit statusChanged("DISCONNECTED"); }

}

void backend::gotError(QAbstractSocket::SocketError err)
{
    QString strError = "unknown";
    switch (err)
    {
        case 0:
            strError = "Connection was refused";
            break;
        case 1:
            strError = "Remote host closed the connection";
            break;
        case 2:
            strError = "Host address was not found";
            break;
        case 5:

            strError = "Connection timed out";

            break;
        default:
            strError = "Unknown error";
    }

    emit someError(100,strError);


}

void backend::gotErrorModbus(int addReg,QString modbus_error)
{

     emit  someError(addReg,modbus_error);
}

void backend::connectClicked(QString host, int port,int slaveId)
{
    client->connect2host(host.toStdString(),port,slaveId);

}

void backend::disconnectClicked()
{
    client->closeConnection();
}

void backend::slotWrittenCoil(bool stateCoil, int number)
{
    emit statusCoil(stateCoil,number);
}

void backend::slotWrittenRegistr(int address, int number)
{
    emit statusReg(address,number);
}

void backend::slotReadHoldings(const std::vector<uint16_t> &range)
{

   std::vector<uint16_t> data(range);
   size_t count_iteration=data.size()/2;
   std::vector<qreal>returnData;
   auto first_iterator = data.begin();
   const auto end_iterator = data.end();

   for(size_t it=0;it<count_iteration;it++)
   {

       if(it!=(count_iteration-1))
       {
          returnData.push_back(this->combain_data(std::vector<uint16_t>({first_iterator,first_iterator+2})));
          first_iterator=first_iterator+2;
       }

       else
       {
            returnData.push_back(this->combain_data(std::vector<uint16_t>({first_iterator,end_iterator})));
       }


   }


     emit statusHoldingsReg(std::move(returnData));

}

void backend::writeCoil(int adress, bool state)
{

    try {
          client->modbus_write_coil(adress,state);

        }
         catch (std::exception& ex) {

           //qDebug()<<ex.what();
           emit someError(adress,ex.what());

    }


}

void backend::writeReg(int address, int value)
{

    try {
          client->modbus_write_register(address,value);

        }catch (std::exception& ex) {

           //qDebug()<<ex.what();
           emit someError(address,ex.what());

       }


}

bool backend::readReg(int address,int count)
{

    try {

        if(count%2!=0)count++;
        size_t different_values=count-address;
        client->modbus_read_holding_registers(address,different_values);

    }  catch (std::exception& ex) {

          emit someError(address,ex.what());
    }

    return true;

}

float& backend::combain_data(const std::vector<uint16_t> &source)
{
   float result;
   uint32_t data=0;
   size_t iteration_value=2;
   int8_t shift_value=iteration_value;

   for(size_t vi=0;vi<iteration_value;vi++)
   {
        if(vi!=1)//3)
       {

           shift_value = shift_value>>vi;
           data|=(source[vi]<<((iteration_value*shift_value)+
                                     (3<<shift_value)));
       }else
        {

           data|=source[vi];
        }

   }


   return result=std::move((*(float*)(&data)));

}




