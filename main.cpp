#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQuickItem>
#include <QQmlContext>

#include "Init/DatabaseController.h"
#include "EmployeesTab/Employees.h"
#include "StorageTab/SizesModel.h"
#include "StorageTab/ClothesTypes/ClothesTypesModel.h"
#include "StorageTab/Clothes/ClothesModel.h"
#include "StorageTab/ClothingItem/ClothesSizesModel.h"
#include "HomeTab/TodoListModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/ClothingStore/images/icon.ico"));

    QQmlApplicationEngine engine;

    DatabaseController *db = new DatabaseController(&app);
    qmlRegisterSingletonInstance("com.company.DatabaseController", 1, 0, "DbController", db);

    Employees *emp = new Employees(&app);
    qmlRegisterSingletonInstance("com.company.Employees", 1, 0, "Emp", emp);

    SizesModel *sizesModel = new SizesModel(&app);
    qmlRegisterSingletonInstance("com.company.SizesModel", 1, 0, "SizesModel", sizesModel);

    ClothesTypesModel *clothesTypesModel = new ClothesTypesModel(&app);
    qmlRegisterSingletonInstance("com.company.ClothesTypesModel", 1, 0, "ClothesTypesModel", clothesTypesModel);

    ClothesModel *clothesModel = new ClothesModel(&app);
    qmlRegisterSingletonInstance("com.company.ClothesModel", 1, 0, "ClothesModel", clothesModel);

    ClothesSizesModel *clothesSizesModel = new ClothesSizesModel(&app);
    qmlRegisterSingletonInstance("com.company.ClothesSizesModel", 1, 0, "ClothesSizesModel", clothesSizesModel);

    TodoListModel *todoListModel = new TodoListModel(&app);
    qmlRegisterSingletonInstance("com.company.TodoListModel", 1, 0, "TodoListModel", todoListModel);

    const QUrl url(u"qrc:/ClothingStore/Main.qml"_qs);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
