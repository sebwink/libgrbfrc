// --------------------------------------------------------------------------
//               grbfrc -- Mixed-integer fractional programming
// --------------------------------------------------------------------------
// Copyright Sebastian Winkler --- Eberhard Karls University Tuebingen, 2016
//
// This software is released under a three-clause BSD license:
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//  * Neither the name of any author or any participating institution
//    may be used to endorse or promote products derived from this software
//    without specific prior written permission.
// For a full list of authors, refer to the file AUTHORS.
// --------------------------------------------------------------------------
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL ANY OF THE AUTHORS OR THE CONTRIBUTING
// INSTITUTIONS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
// OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
// OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// --------------------------------------------------------------------------
// $Maintainer: Sebastian Winkler $
// $Authors: Sebastian Winkler $
// --------------------------------------------------------------------------
//

#ifndef DINKELBACH_HPP
#define DINKELBACH_HPP

#include <string>
#include <vector>

#include "common.hpp"
#include "Algorithm.hpp"
#include "GrbfrcCallback.hpp"

namespace grbfrc
{

class Dinkelbach : public _Algorithm {

  private:

    double q_init { 0.0 };
    int max_iter { 30 };
    int time_limit { 3600 };
    double tol { 0.0001 };
    FMILPSol solution;

  public:

    Dinkelbach(double qi = 0.0,
               int maxit = 30,
               int maxsec = 3600,
               double tolerance = 0.0001);
    // set initial q ================================================================= //
    void set_q_init(double qi);
    // set maximal number of iterations ============================================== //
    void set_max_iter(int max);
    // set time limit (in seconds) =================================================== //
    void set_time_limit(int seconds);
    // set tolerance ================================================================= //
    void set_tolerance(double tolerance);
    // run Dinkelbach's algorithm ==================================================== //
    template <typename T>
    void run(GrbfrcCallback<T>* cb = nullptr,
             bool verbose = true,
             bool logFile = true,
             std::string logFileName = "grbfrc.log") {

        if (cb) {
            callback = cb->yield();
            base_model->setCallback(callback);
            base_model->update();
        }

        _run(verbose, logFile, logFileName);

    }

    void _run(bool verbose, bool logFile, std::string logFileName);

    // write solution ================================================================ //
    virtual void writeSolution(FMILPSol** xsolution) override;
    // get solution ================================================================== //
    FMILPSol getSolution();

  private:

    // messages ====================================================================== //
    void printProblem(int status,
                      int iter);
    void printIteration(int iter);

 };

}        // namespace grbfrc

#endif   // DINKELBACH_HPP
