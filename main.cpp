#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{

    qputenv("QT_OPENGL", "angle");
    QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);

    QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
