#include "vec_copy.hpp"
#include "gtest/gtest.h"

struct test_mem {
  int * in, * out;
  unsigned int size;
};

// prepare memory object for each test case
class vecCopyTest : public ::testing::Test {
protected:  
  void SetUp() override {
    m1.size = 10;
    m1.in = new int[m1.size];
    m1.out = new int[m1.size];

    for(unsigned int i = 0; i < m1.size; ++i){
      m1.in[i] = static_cast<int>(i);
    }
  }

  void TearDown() override {
    delete[] m1.in;
    delete[] m1.out;
  }
  
  test_mem m1;
};


TEST_F(vecCopyTest, testInOutSame) {
  EXPECT_EQ(0, vec_copy(m1.in, m1.out, m1.size));
  for(unsigned int i = 0; i < m1.size; ++i){
    EXPECT_EQ(m1.in[i], m1.out[i]);
  }
}
