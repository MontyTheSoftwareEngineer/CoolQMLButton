#ifndef EXAMPLECLASS_H
#define EXAMPLECLASS_H

#include <QObject>
#include <QTimer>

class ExampleClass : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int exampleProgress READ exampleProgress WRITE setExampleProgress NOTIFY exampleProgressChanged)
public:
    explicit ExampleClass(QObject *parent = nullptr);
    int exampleProgress();
    Q_INVOKABLE void beginProcess();

public slots:
    void setExampleProgress( int progress );
    void timerTimeout();
signals:
    void exampleProgressChanged();
    void processComplete();
    void processing();

private:
    QTimer * m_tickTimer;
    int m_exampleProgress;
};

#endif // EXAMPLECLASS_H
