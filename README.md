<h1 align="center">
  <img src="docs/icon.png" width="256" height="256" alt="MenubarAirAlerts Icon"/>
  <br/>
  MenubarAirAlerts
</h1>

📢 **MenubarAirAlerts** — це Swift-додаток, який виводить поточний статус повітряної тривоги в Menubar вашого Mac. Додаток з простою конфігурацією працює у фоновому режимі та автоматично оновлює дані з [API повітряних тривог](https://ubilling.net.ua/aerialalerts/).

![Скриншот програми](docs/screenshot.png)

## 🧩 Особливості

- ✅ Показує актуальний статус тривоги у Menubar (🟢 / 🔴)
- 🔄 Автоматичне оновлення даних у реальному часі
- 🧼 Мінімалістичний інтерфейс — тільки найнеобхідніше
- 🔒 Без трекінгу, аналітики та збору даних

## 🛠 Збірка проєкту вручну

### 🔧 Вимоги:

- macOS 13 (Ventura) або новіше
- Xcode 14 або новіше
- Swift 5+

### 📦 Збірка:

1. Склонувати репозиторій: 

    ```bash
    git clone https://github.com/denipolis/MenubarAirAlerts.git
    cd MenubarAirAlerts
    ```
2. Відкрити проєкт у Xcode:

    ```bash
    open MenubarAirAlerts.xcodeproj
    ```
3. Зібрати:
    - **⌘ Command + R** або **Product > Run**
    - Після збірки **XCode** відкриє **MenubarAirAlerts**.

4. Щоб отримати готовий .app файл:
    - Product > Show Build Folder in Finder
    - У відкритій директорії знайти `Products` > `Debug` > `MenubarAirAlerts.app`
