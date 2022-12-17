#ifndef TEST_FUNCS_HPP
#define TEST_FUNCS_HPP

#include <string>
#include <vector>
#include <assert.h>
#include <math.h>

using namespace std;

double handle_call(const string &func_name, vector<double> *parameters) {
	#define FUNC_ONE(name) if (func_name == #name) { \
	  assert(parameters->size() == 1); \
	  return name(parameters->operator[](0)); \
	} else

	#define FUNC_TWO(name) if (func_name == #name) { \
	  assert(parameters->size() == 2); \
	  return name(parameters->operator[](0), parameters->operator[](1)); \
	} else

	FUNC_ONE(abs)
	FUNC_ONE(cos)
	FUNC_ONE(sin)
	FUNC_ONE(tan)
	FUNC_ONE(acos)
	FUNC_ONE(asin)
	FUNC_ONE(atan)
	FUNC_ONE(cosh)
	FUNC_ONE(sinh)
	FUNC_ONE(tanh)
	FUNC_ONE(acosh)
	FUNC_ONE(asinh)
	FUNC_ONE(atanh)
	FUNC_ONE(exp)
	FUNC_ONE(log)
	FUNC_ONE(log10)
	FUNC_ONE(exp2)
	FUNC_ONE(expm1)
	FUNC_ONE(log2)
	FUNC_ONE(sqrt)
	FUNC_ONE(logb)
	FUNC_TWO(pow)
	FUNC_ONE(floor)
	FUNC_ONE(round)
	{
		fprintf(stderr, "unknow:%s\n", func_name.c_str());
		exit(-1);
	}
}

#endif //TEST_FUNCS_HPP
