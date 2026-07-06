/* Templated FIR filter

 Compile
    g++ -std=c++11 fir_filter_template.cpp

 Run
    ./a.out

 From the MATLAB Command line
    system("g++ -std=c++11 fir_filter_template.cpp")
    system("./a.out")
*/

#include <iostream>
#include <vector>

template <typename Tcoefficient, typename Tinput, typename Tsum>
Tsum fir_filter(std::vector<Tcoefficient> b,
                Tinput x,
                std::vector<Tinput>& z,
                size_t &p)
{
    const size_t nb = b.size();
    Tsum acc;
    size_t k;
    p++; if (p>=nb){p=0;}
    z[p] = x;
    k = p;
    acc = 0;
    for (size_t j = 1; j <= nb; j++) {
        k++; if (k>=nb){k=0;}
        acc += b[nb - j] * z[k];
    }
    return acc;
}

int main(int argc, const char * argv[]) {

    { // float types

        // Number of inputs
        const size_t N = 10;

        // Coeffcients
        // T.coefficient = single([]);
        // b = cast(fir1(7,0.5),'like',T.coefficient)
        std::vector<float> b = {-0.0052, -0.0229, 0.0968, 0.4313, 0.4313, 0.0968, -0.0229, -0.0052};

        // Impulse input
        // T.input = single([]);
        // x = zeros(1,N,'like',T.input);
        // x(1) = 1;
        std::vector<float> x(N,0.0);
        x[0] = 1.0;

        // z = zeros(size(b),'like',T.input)
        std::vector<float> z(b.size(),0.0);
        std::vector<float> y(N);
        size_t p = 0;
        for (int n=0; n<N; n++) {
            y[n] = fir_filter<float,float,float>(b,x[n],z,p);
        }
        std::cout << std::endl << "float type" << std::endl;
        for (int n=0; n<N; n++) {
            std::cout << "y["<<n<<"] = " << y[n] << std::endl;
        }
    }

    { // fixed-point types

        // Number of inputs
        const size_t N = 10;

        // Coefficients
        // T.coefficient = fi([],1,16,15);
        // b = cast(fir1(7,0.5),'like',T.coefficient)
        // int(b)
        std::vector<short> b = {-169, -750, 3170, 14133, 14133, 3170, -750, -169};

        // Impulse input
        // T.input = fi([],1,16,14);
        // x = zeros(1,N,'like',T.input);
        // x(1) = 1;
        std::vector<short> x(N,0);
        x[0] = 16384; // = 1 * 2^14 = int(x(1))

        // z = zeros(size(b),'like',T.input)
        std::vector<short> z(b.size(),0);

        // T.output = fi([],1,16,14);
        // y = zeros(1,N,'like',T.output)
        std::vector<short> y(N);
        size_t p = 0;
        for (int n=0; n<N; n++) {
            // Cast sum type to output type by right-shifting
            y[n] = fir_filter<short,short,int>(b,x[n],z,p) >> 14;
        }
        std::cout << std::endl << "fixed-point type" << std::endl;
        for (int n=0; n<N; n++) {
            std::cout << "y["<<n<<"] = " << y[n] << std::endl;
        }
    }
    
    
    return 0;
}
