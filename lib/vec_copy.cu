#include "vec_copy.hpp"

__global__ void copy_kernel(int  * const in, int *out, const unsigned int size){
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  if( i < size)
    out[i] = in[i];
}

int vec_copy(int * const in, int * out, unsigned int size){
  int * d_in, * d_out;

  cudaError_t cudaError;

  // assignment is wanted
  if( cudaError = cudaMalloc( (void **)&d_in, sizeof(int)*size) ){
      return cudaError;
  }

  if( cudaError = cudaMalloc( (void **)&d_out, sizeof(int)*size) ){
    return cudaError;
  }

  if( cudaError = cudaMemcpy(d_in, in, sizeof(int)*size, cudaMemcpyHostToDevice ) ){
    return cudaError;
  }

  copy_kernel<<<1,size>>>(d_in, d_out, size);
  if( cudaError = cudaGetLastError() ){
    return cudaError;
  }

  if( cudaError = cudaMemcpy(out, d_out, sizeof(int)*size, cudaMemcpyDeviceToHost ) ){
    return cudaError;
  }

  cudaFree(d_in);
  cudaFree(d_out);
  
  return 0;
}
