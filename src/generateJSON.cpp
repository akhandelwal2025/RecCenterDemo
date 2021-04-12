#include "generateJSON.hpp"

int GenerateJSON::getDaysInMonth(std::string month, int year){
    std::map<std::string, int> daysDict = {
        {"January", 31},
        {"March", 31},
        {"April", 30},
        {"May", 31},
        {"June", 30},
        {"July", 31},
        {"August", 31},
        {"September", 30},
        {"October", 31},
        {"November", 30},
        {"December", 31}
    }
    if(month == "February"){
        if(year%4==0){
            return 29
        }
        else{
            return 28
        }
    }
}