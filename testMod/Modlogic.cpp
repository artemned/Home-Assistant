#include "Modlogic.h"
#include <algorithm>
#include <iterator>

using namespace std;



modbus::modbus(): QObject()
{

    tcp_socket = new QTcpSocket();
    msg_id_ = 1;
    timeout_timer = new QTimer();
    timeout_timer->setSingleShot(true);


   connect(timeout_timer, &QTimer::timeout, this, &modbus::connectionTimeout);
   connect(tcp_socket, &QTcpSocket::disconnected, this, &modbus::closeConnection);
   connect(tcp_socket,&QIODevice::channelReadyRead,this,&modbus::beginReciev);

}

modbus:: ~modbus() {
    closeConnection();
    modbus_close();

}

void modbus::beginReciev()
{
    QByteArray array;
    std::vector<uint8_t> vec;

   try {

 for(;;)
  {

      if(tcp_socket->bytesAvailable()>0)
     {
        array = tcp_socket->readAll();
        tcp_socket->flush();
        array.toBase64(QByteArray::Base64Encoding);
        uint8_t size_array=array.size();
        vec.resize(size_array);
        QDataStream stream(array);
        size_t next_index=0;

     while(!stream.atEnd())
      {
         stream>>vec[next_index++];

      }

//         for(auto in=0;in<size_array;in++)
//         {
//             qDebug()<<vec[in]<<"|";
//         }
//

     }


      break;
}


    modbus_error_handle(vec);


}  catch (std::exception& e) {

    emit modbusError(address_error_registr_,e.what());

}

 query_filter(std::move(vec));

}

void modbus::connected()
{
    connected_ = true;
    emit statusChanged(connected_);
}

void modbus::connectionTimeout()
{

    if(tcp_socket->state() == QAbstractSocket::ConnectingState)
    {
        tcp_socket->abort();
        emit tcp_socket->errorOccurred(QAbstractSocket::SocketTimeoutError);//error


    }

}

void modbus::connect2host(std::string host, uint16_t port,uint16_t slaveId)
{

    this->host_=host;
    this->port_=port;
    this->slaveid_=slaveId;

    modbus_set_slave_id(slaveId);

    timeout_timer->start(2000);

    tcp_socket->connectToHost(QString::fromStdString(host),port,
                                                  QIODevice::ReadWrite);

    connect(tcp_socket,SIGNAL(connected()),SLOT(connected()));

}

void modbus::closeConnection()
 {
     timeout_timer->stop();

     disconnect(tcp_socket, &QTcpSocket::connected, 0, 0);

     bool shouldEmit = false;
     switch (tcp_socket->state())
     {
         case 0:
             tcp_socket->disconnectFromHost();
             shouldEmit = true;
             break;
         case 2:
             tcp_socket->abort();
             shouldEmit = true;
             break;
         default:
             tcp_socket->abort();
     }

     if (shouldEmit)
     {
         connected_ = false;
         slaveid_=0;
         msg_id_=0;
         emit statusChanged(connected_);

      // modbus_close();//what to do it method
     }
 // modbus_close();

 }

void modbus::modbus_close() {

    connected_=false;
}

void modbus::modbus_set_slave_id(uint16_t id) {
     slaveid_ = id;
 }

bool modbus::get_connect() const
{
    return connected_;
}

void modbus::modbus_build_request(uint8_t* to_send, int address, int func) {
    to_send[0] = (uint8_t)(msg_id_ >> 8);//id transaction
    to_send[1] = (uint8_t)(msg_id_ & 0x00FF);//id transaction
    to_send[2] = 0;//id protocol
    to_send[3] = 0;// id protocol
    to_send[4] = 0;//lengt package
    to_send[6] = (uint8_t)slaveid_;//id slave
    to_send[7] = (uint8_t)func;// code function
    to_send[8] = (uint8_t)(address >> 8); // address first registr
    to_send[9] = (uint8_t)(address & 0x00FF); // address first registr
    this->address_error_registr_=address;
    this->function_code_=func;
}

void modbus::modbus_read(int address, int amount, int func) {
    uint8_t to_send[12];
    modbus_build_request(to_send, address, func);
    to_send[5] = 6;//lenght package
    to_send[10] = (uint8_t)(amount >> 8); // count registers
    to_send[11] = (uint8_t)(amount & 0x00FF); // count registers
    modbus_send(to_send, 12);
}

size_t modbus::modbus_send(uint8_t* to_send, int length) {

    msg_id_++;
    return tcp_socket->write((const char*)to_send,length);

 }

size_t modbus::modbus_receive(uint8_t* buffer) {


 return  tcp_socket->read((char*)buffer,255);

}

void modbus::modbus_write(int address,int func, uint16_t* value) {


        uint8_t* to_send = new uint8_t[12];
        modbus_build_request(to_send, address, func);
        to_send[5] = 6;
        to_send[10] = (uint8_t)(value[0] >> 8);
        to_send[11] = (uint8_t)(value[0] & 0x00FF);
        modbus_send(to_send, 12);
        delete[]to_send;

}

void modbus::modbus_write_coil(uint16_t address, bool to_write) {
    if (connected_)
    {
        if (address > 65535)
        {
            throw modbus_amount_exception();           
        }

           int value = to_write * 0xFF00;
           modbus_write(address,WRITE_COIL, (uint16_t*)& value);

    } else {
            throw modbus_connect_exception();
           }

}

void modbus::modbus_write_register(uint16_t address, uint16_t value)
{

           if (connected_) {
            if (address > 65535)
            {
                throw modbus_amount_exception();

            }
              modbus_write(address, WRITE_REG, &value);

        }else {
               throw modbus_connect_exception();
              }
}

void modbus::modbus_read_holding_registers(uint16_t address,int amount)// int16_t *buffer)
{

        if (connected_)
        {
            if (amount > 65535 || address > 65535)
            {
                throw modbus_amount_exception();
            }

            modbus_read(address, amount, READ_REGS);
        } else
         {
             throw modbus_connect_exception();
         }
}

void modbus::read_regist(const std::vector<uint8_t>& range)
{

     std::vector<uint8_t> vectsep(range);
     reverse(vectsep.begin(),vectsep.end());
     size_t size_range=range.size();
     size_t offset=1;
     std::vector<uint16_t> data;

     for(size_t it = 0; it < size_range/2; it++)
     {
         offset+=1;

         if(it>=1)
         {
             data.push_back(uint16_t(vectsep.at(offset)<<8)|vectsep.at(offset-1));
             offset+=1;

         }else{

               data.push_back(uint16_t(vectsep.at(it+1)<<8)|vectsep.at(it));// (it==1 and it==0)-shift loud and hight byts
         }

     }

    reverse(data.begin(),data.end()); // test range collection (revers) and write metod for backend

    emit signalReadHoldings(std::move(data));


 }

void modbus::query_filter(const std::vector<uint8_t>& requestResponse)
 {

        switch (requestResponse[7])
        {

        case 5: emit signalWriteCoil(requestResponse[10],requestResponse[9]);
                break;

        case 6: emit signalWrittenRegistr(requestResponse[9],requestResponse[11]);
                break;

        case 3: {
                  auto first_iterator=requestResponse.begin()+9;
                  const auto end_iterator=first_iterator+requestResponse[8];
                  read_regist(std::vector<uint8_t>{first_iterator,end_iterator});

                }
                break;


        default:break;

        }


}

void modbus::modbus_error_handle(const vector<uint8_t>& msg) {

     uint8_t error = function_code_ + 0x80;
     if(msg[6]!=slaveid_)
     {
          throw modbus_slave_exception();
     }

     if (msg[7] == error)
     {
        switch (msg[8]) {
        case EX_ILLEGAL_FUNCTION:
            throw modbus_illegal_function_exception();
        case EX_ILLEGAL_ADDRESS:
            throw modbus_illegal_address_exception();
        case EX_ILLEGAL_VALUE:
            throw modbus_illegal_data_value_exception();
        case EX_SERVER_FAILURE:
            throw modbus_server_failure_exception();
        case EX_ACKNOWLEDGE:
            throw modbus_acknowledge_exception();
        case EX_SERVER_BUSY:
            throw modbus_server_busy_exception();
        case EX_GATEWAY_PROBLEMP:        
            throw modbus_gateway_exception();
        case EX_SLAVE_PROBLEM:
            throw modbus_slave_exception();
        default:
            break;
        }

    }

}
