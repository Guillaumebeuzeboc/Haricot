#include "a_lib/lib.hpp"

void liba_function()
  {

    using namespace boost::gregorian;

    try {
      // The following date is in ISO 8601 extended format (CCYY-MM-DD)
      std::string s("2001-10-9"); //2001-October-09
      date d(from_simple_string(s));
      std::cout << to_simple_string(d) << std::endl;
    }
    catch(std::exception& e) {
      std::cout << "  Exception: " <<  e.what() << std::endl;
    }
  }
