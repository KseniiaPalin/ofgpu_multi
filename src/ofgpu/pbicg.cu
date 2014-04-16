/***************************************************************************
    begin                : Thu Mar 24 2011
    copyright            : (C) 2011 Symscape
    website              : www.symscape.com
***************************************************************************/
/*
    This file is part of ofgpu.

    ofgpu is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    ofgpu is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with ofgpu.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <cusp/krylov/bicgstab.h>

#include "ofgpu/pbicg.h"
#include "ofgpu/sparsematrixsystem.h"


namespace ofgpu
{
  struct PBiCGSolver
  {
    template <class LinearOperator,
	      class Vector,
	      class Monitor,
	      class Preconditioner>
    static void perform(LinearOperator& A,
			Vector& x,
			Vector& b,
			Monitor& monitor,
			Preconditioner& M)
    {
      cusp::krylov::bicgstab(A, x, b, monitor, M);
    }
  };
}


extern "C"
OFGPU_EXPORT void ofgpuPBiCGsolve(ofgpu::SparseMatrixArgs const & args)
{
  using namespace ofgpu;

  the<SparseMatrixSystem>().solve<PBiCGSolver>(args);
}