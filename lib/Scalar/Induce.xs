#define PERL_NO_GET_CONTEXT
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

//#ifdef MULTICALL 
//#define USE_MULTICALL
//#endif

static int run = 0;

MODULE = Scalar::Induce								PACKAGE = Scalar::Induce

PROTOTYPES: DISABLED

void
induce(block, var)
	CV* block;
	SV* var;
	PROTOTYPE: &$
	PPCODE:
#ifdef USE_MULTICALL
		SV **args_base = &PL_stack_base[ax - 1];
		AV* ret = newAV();
		I32 gimme = G_ARRAY;
		++run;
		PUTBACK;
		SAVESPTR(DEFSV);
		DEFSV = sv_mortalcopy(var);
		dMULTICALL;
		PUSH_MULTICALL(block);
		while (SvOK(DEFSV)) {
			int j;
			MULTICALL;
			SPAGAIN;
			for(j = cx->blk_oldsp; j < sp - args_base; ++j) {
				if (!SvPADSTALE(ST(j)))
					ST(j) = sv_mortalcopy(ST(j));
				av_push(ret, SvREFCNT_inc(ST(j)));
			}
			cx->blk_oldsp = sp - args_base;
		}
		POP_MULTICALL;
		SAVEMORTALIZESV(ret);
#else
		SAVESPTR(DEFSV);
		DEFSV = sv_mortalcopy(var);
		while (SvOK(DEFSV)) {
			PUSHMARK(SP);
			call_sv((SV*)block, G_ARRAY);
			SPAGAIN;
		}
#endif

void
void(...)
	CODE:

