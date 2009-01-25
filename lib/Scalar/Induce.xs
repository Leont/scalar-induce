#define PERL_NO_GET_CONTEXT
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

//#ifdef MULTICALL 
//#define USE_MULTICALL
//#endif

MODULE = Scalar::Induce				PACKAGE = Scalar::Induce

PROTOTYPES: DISABLED

void
induce(block, var)
	CV* block;
	SV* var;
	PROTOTYPE: &$
	PPCODE:
#ifdef USE_MULTICALL
		SAVESPTR(DEFSV);
		DEFSV = sv_mortalcopy(var);
		dMULTICALL;
		I32 gimme = G_ARRAY;
		PUSH_MULTICALL(block);
		FREETMPS; LEAVE;
		while (SvOK(DEFSV)) {
			PUSHMARK(SP);
			MULTICALL;
			SPAGAIN;
			PUTBACK;
		}
		ENTER; SAVETMPS;
		POP_MULTICALL;
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

BOOT:
{
	sv_setiv(get_sv("Scalar::Induce::uses_xs", TRUE | GV_ADDMULTI ), 1);
}

