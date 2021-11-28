
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "backend.h"
#include "QThread"

int main(int argc, char *argv[])
{


    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<backend>("io.qt.Backend", 1, 0, "Backend");


    //app.setWindowIcon()
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    //QObject::connect(&engine,&QQmlApplicationEngine::quit,&QGuiApplication::quit);

    if (engine.rootObjects().isEmpty()) { return -1; }

   return app.exec();
}
