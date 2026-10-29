#include <string.h>

// IBM APIs
#include <qsnapi.h>

class Screen {
public:
    void clear() {
        // '4' means use 27x132 mode
        QsnClrScr('4', 0, 0, NULL);
    }

    void showText(const char* text, Q_Bin4 row, Q_Bin4 column) {
        QsnWrtDta(text, strlen(text), 0, row, column, QSN_SA_HI,
                  QSN_SA_NORM, QSN_SA_BLU, QSN_SA_NORM, NULL, 0, NULL);
    }

    bool pressedF(unsigned short fkey) {
        unsigned char aid_code;
        QsnGetAID(&aid_code, 0, NULL);
        return aid_code == QSN_F3;
    }


    Screen() {
        this->clear();
    }
};

int main() {
    Screen screen;

    screen.showText("Hello, press F3 to proceed", 5, 10);

    while (!screen.pressedF(3)) {}

    screen.showText("Press F3 again to quit", 6, 10);

    while (!screen.pressedF(3)) {}
}
