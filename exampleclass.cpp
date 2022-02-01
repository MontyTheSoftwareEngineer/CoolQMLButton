#include "exampleclass.h"
#include <QDebug>
ExampleClass::ExampleClass(QObject *parent)
    : QObject(parent)
    , m_exampleProgress( 0 )
{
    m_tickTimer = new QTimer( this );
    m_tickTimer->setInterval(75);
    m_tickTimer->setSingleShot( true );

    connect( m_tickTimer, &QTimer::timeout, this, &ExampleClass::timerTimeout);
}

void ExampleClass::beginProcess()
{
    emit processing();
    m_tickTimer->start();
}

int ExampleClass::exampleProgress()
{
    return m_exampleProgress;
}

void ExampleClass::setExampleProgress( int progress )
{
    if ( m_exampleProgress == progress )
    {
        return;
    }


    if ( progress < 100 ) {
        m_exampleProgress = progress;
        emit exampleProgressChanged();
        m_tickTimer->start();
    }
    else
    {
        emit processComplete();
    }
}

void ExampleClass::timerTimeout()
{
    int newProgress = m_exampleProgress;
    newProgress += 5;

    setExampleProgress( newProgress );
}
