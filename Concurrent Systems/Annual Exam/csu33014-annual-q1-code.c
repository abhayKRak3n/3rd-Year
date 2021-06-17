//
// CSU33014 Annual Exam, May 2021
// Question 1
//

// Please examine version each of the following routines with names
// starting 'routine_'. Where the routine can be vectorized, please
// replace the corresponding 'vectorized' version using SSE vector
// intrinsics. Where it cannot be vectorized please explain why.

// To illustrate what you need to do, routine_0 contains a
// non-vectorized piece of code, and vectorized_0 shows a
// corresponding vectorized version of the same code.

// Note that to simplify testing, I have put a copy of the original
// non-vectorized code in the vectorized version of the code for
// routines 1 to 6. This allows you to easily see what the output of
// the program looks like when the original and vectorized version of
// the code produce equivalent output.

// Note the restrict qualifier in C indicates that "only the pointer
// itself or a value directly derived from it (such as pointer + 1)
// will be used to access the object to which it points".


#include <immintrin.h>
#include <stdio.h>

#include "csu33014-annual-q1-code.h"

/****************  routine 0 *******************/

// Here is an example routine that should be vectorized
void routine_0(float * restrict a, float * restrict b,
		    float * restrict c) {
  for (int i = 0; i < 1024; i++ ) {
    a[i] = b[i] * c[i];
  }
}

// here is a vectorized solution for the example above
void vectorized_0(float * restrict a, float * restrict b,
		    float * restrict c) {
  __m128 a4, b4, c4;
  
  for (int i = 0; i < 1024; i = i+4 ) {
    b4 = _mm_loadu_ps(&b[i]);
    c4 = _mm_loadu_ps(&c[i]);
    a4 = _mm_mul_ps(b4, c4);
    _mm_storeu_ps(&a[i], a4);
  }
}

/***************** routine 1 *********************/

// in the following, size can have any positive value
float routine_1(float * restrict a, float * restrict b,
		int size) {
  float sum_a = 0.0;
  float sum_b = 0.0;
  
  for ( int i = 0; i < size; i++ ) {
    sum_a = sum_a + a[i];
    sum_b = sum_b + b[i];
  }
  return sum_a * sum_b;
}

// in the following, size can have any positive value
float vectorized_1(float * restrict a, float * restrict b, int size) {
  
	// setting both sum variables to 0
	__m128 sumA4 = _mm_set1_ps(0.f);
	__m128 sumB4 = _mm_set1_ps(0.f);	
	__m128 a4, b4, t4;

	for (int i = 0; i < size; i+=4) {
		a4 = _mm_loadu_ps(&a[i]); 
		sumA4 = _mm_add_ps(sumA4, a4);	// loading value onto a4 and adding with sum variable 

		b4 = _mm_loadu_ps(&b[i]);
		sumB4 = _mm_add_ps(sumB4, b4);
	}
	t4 = _mm_mul_ps(sumA4, sumB4);
	return t4[0];


}

/******************* routine 2 ***********************/

// in the following, size can have any positive value
void routine_2(float * restrict a, float * restrict b, int size) {
  for ( int i = 0; i < size; i++ ) {
    a[i] = 1.5379 - (1.0/b[i]);
  }
}


void vectorized_2(float * restrict a, float * restrict b, int size) {
  
	__m128 a4,b4;
	__m128 decimalVal = _mm_set1_ps(1.5379f);

	int max = size - (size % 4);

  for ( int i = 0; i < max; i+=4 ) {
	  b4 = _mm_loadu_ps(&b[i]);		// loads value of b[i]
	  b4 = _mm_rcp_ps(b4);		// takes reciprocal of b4
	  a4 = _mm_sub_ps(decimalVal, b4);
  }

  // calculate the remaining values 
  for (int i = max; i < size; i++) {
	  a[i] = 1.5379 - (1.0 / b[i]);
  }
}

/******************** routine 3 ************************/

// in the following, size can have any positive value
void routine_3(float * restrict a, float * restrict b, int size) {
  for ( int i = 0; i < size; i++ ) {
    if ( a[i] < b[i] ) {
      a[i] = b[i];
    }
  }
}


void vectorized_3(float * restrict a, float * restrict b, int size) {

	__m128 a4, b4, cmp;
	int max = size - (size % 4);

  for ( int i = 0; i < max; i+=4 ) {
	  a4 = _mm_loadu_ps(&a[i]);
	  b4 = _mm_loadu_ps(&b[i]);		// loading required values

	  cmp = _mm_cmplt_ps(a4, b4);	// compares a[i] and b[i] using complement func
	  a4 = _mm_blendv_ps(a4, b4, cmp);	

	  _mm_storeu_ps(&a[i], a4);
  }

  // calculate the remaining values 
  for (int i = max; i < size; i++) {
	  if (a[i] < b[i]) {
		  a[i] = b[i];
	  }
  }
}

/********************* routine 4 ***********************/

// hint: one way to vectorize the following code might use
// vector shuffle operations
void routine_4(float * restrict a, float * restrict b,
		 float * restrict c) {
  for ( int i = 0; i < 2048; i = i+2  ) {
    a[i] = b[i]*c[i+1] + b[i+1]*c[i];
    a[i+1] = b[i]*c[i] - b[i+1]*c[i+1];
  }
}


void vectorized_4(float * restrict a, float * restrict b,
		    float * restrict  c) {
  
	__m128 b4, c4, b1, b2, c1, t1, t2, result;
	int i;

	for (i = 0; i < 2048; i += 4) {
		b4 = _mm_loadu_ps(&b[i]);
		c4 = _mm_loadu_ps(&c[i]);	// values for b[i] and c[i]

		b1 = _mm_shuffle_ps(b4, b4, _MM_SHUFFLE(2, 2, 0, 0));
		b2 = _mm_shuffle_ps(b4, b4, _MM_SHUFFLE(3, 3, 1, 1));
		c1 = _mm_shuffle_ps(c4, c4, _MM_SHUFFLE(2, 3, 0, 1));	// retrieving values for b[i+1],c[i+1] and so on		

		t1 = _mm_mul_ps(b1, c4);
		t2 = _mm_mul_ps(b2, c1);		// performing required operation
		
		result = _mm_addsub_ps(t1, t2);	// allocating result
		_mm_storeu_ps(&a[i], _mm_shuffle_ps(result, result, _MM_SHUFFLE(2, 3, 0, 1)));
	}
}

/********************* routine 5 ***********************/

// in the following, size can have any positive value
int routine_5(unsigned char * restrict a,
	      unsigned char * restrict b, int size) {
  for ( int i = 0; i < size; i++ ) {
    if ( a[i] != b[i] )
      return 0;
  }
  return 1;
}

int vectorized_5(unsigned char * restrict a,
		 unsigned char * restrict b, int size) {
  
	__m128i *ai = (__m128i *) a;
	__m128i *bi = (__m128i *) b;
	__m128i a16, b16, temp;
	int i;

	for (i = 0; i < size - 16; i += 16) {
		
		a16 = _mm_loadu_si128(&ai[i / 16]);
		b16 = _mm_loadu_si128(&bi[i / 16]);		// load character values
		
		temp = _mm_cmpeq_epi8(a16, b16);		// compare vectors
		if (_mm_movemask_epi8(temp) == 0xFF) {
			return 0;
		}
	}

	// evaluate remaining part normally
	for (; i < size; i++) {
		if (a[i] != b[i])
			return 0;
	}

	return 1;
}

/********************* routine 6 ***********************/

void routine_6(float * restrict a, float * restrict b,
		       float * restrict c) {
  a[0] = 0.0;
  for ( int i = 1; i < 1023; i++ ) {
    float sum = 0.0;
    for ( int j = 0; j < 3; j++ ) {
      sum = sum +  b[i+j-1] * c[j];
    }
    a[i] = sum;
  }
  a[1023] = 0.0;
}

void vectorized_6(float * restrict a, float * restrict b,
		       float * restrict c) {
	c[3] = 0.f;
	__m128 b4, c4,sum4;
	c4 = _mm_loadu_ps(&c[0]);
	
	a[0] = 0.0;
	for (int i = 1; i < 1023; i++) {
		b4 = _mm_loadu_ps(&b[i - 1]);	// loads b[i+0-1] till b[i+2-1] in b4
		b4 = _mm_mul_ps(b4, c4);	// using the same variable to save space, b[i+j-1] * c[j]
		b4 = _mm_hadd_ps(b4, b4);	
		b4 = _mm_hadd_ps(b4, b4);	
		a[i] = b4[0];	// a[i] = sum
	}

	a[1023] = 0.0;
}



