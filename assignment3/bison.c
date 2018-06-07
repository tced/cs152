/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "mini_l.y" /* yacc.c:339  */


#include "heading.h"
int yylex(void);
void yyerror(const char *s);
void grab_variables();  
void grab_operators_frm_vector(); 
extern int linenum;
extern int col;

int param_val = 0; 
vector <string> function_table; 
std::vector <string> symbol_table; 
std::vector <string> symbol_type; 
std::vector <string> parameter_table; 
bool go_to_param_table = false; 
std::vector <string> oper_vector;
std::vector <string> mil_vector; 
string temp_string; 
int temp_count; 
int label_count; 
vector <vector <string> > if_label; 
vector <vector <string> > loop_label; 
stack <string> param_queue;
stack <string> read_queue; 
stringstream m; 

//grabs the variables for the COMP rules  
string new_temp_var; 
//grabs appropriate operation from rule 
string grab_operation;

#line 99 "mini_l.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif

/* In a future release of Bison, this section will be replaced
   by #include "mini_l.tab.h".  */
#ifndef YY_YY_MINI_L_TAB_H_INCLUDED
# define YY_YY_MINI_L_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    FUNCTION = 258,
    BEGIN_PARAMS = 259,
    END_PARAMS = 260,
    BEGIN_BODY = 261,
    token = 262,
    END_BODY = 263,
    BEGIN_LOCALS = 264,
    END_LOCALS = 265,
    INTEGER = 266,
    ARRAY = 267,
    OF = 268,
    IF = 269,
    THEN = 270,
    ENDIF = 271,
    ELSE = 272,
    WHILE = 273,
    DO = 274,
    BEGINLOOP = 275,
    ENDLOOP = 276,
    CONTINUE = 277,
    READ = 278,
    WRITE = 279,
    TRUE = 280,
    FALSE = 281,
    AND = 282,
    OR = 283,
    NOT = 284,
    SEMICOLON = 285,
    COLON = 286,
    COMMA = 287,
    L_PAREN = 288,
    R_PAREN = 289,
    L_SQUARE_BRACKET = 290,
    R_SQUARE_BRACKET = 291,
    ASSIGN = 292,
    RETURN = 293,
    NUMBER = 294,
    IDENT = 295,
    MULT = 296,
    DIV = 297,
    MOD = 298,
    ADD = 299,
    SUB = 300,
    LT = 301,
    LTE = 302,
    GT = 303,
    GTE = 304,
    EQ = 305,
    NEQ = 306
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 34 "mini_l.y" /* yacc.c:355  */

   int num_val;
   char* sval; 

#line 196 "mini_l.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_MINI_L_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 213 "mini_l.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  6
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   158

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  52
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  41
/* YYNRULES -- Number of rules.  */
#define YYNRULES  82
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  166

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   306

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    66,    66,    69,    70,    74,    77,    80,    80,   109,
     110,   113,   116,   117,   120,   126,   133,   137,   146,   147,
     148,   149,   150,   151,   152,   164,   171,   177,   189,   210,
     217,   222,   229,   247,   256,   264,   280,   286,   294,   301,
     309,   312,   322,   337,   338,   341,   353,   354,   362,   363,
     371,   372,   382,   388,   395,   401,   404,   405,   406,   407,
     408,   409,   413,   416,   417,   423,   431,   434,   435,   443,
     451,   459,   460,   468,   476,   484,   488,   499,   507,   510,
     515,   522,   527
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "FUNCTION", "BEGIN_PARAMS", "END_PARAMS",
  "BEGIN_BODY", "token", "END_BODY", "BEGIN_LOCALS", "END_LOCALS",
  "INTEGER", "ARRAY", "OF", "IF", "THEN", "ENDIF", "ELSE", "WHILE", "DO",
  "BEGINLOOP", "ENDLOOP", "CONTINUE", "READ", "WRITE", "TRUE", "FALSE",
  "AND", "OR", "NOT", "SEMICOLON", "COLON", "COMMA", "L_PAREN", "R_PAREN",
  "L_SQUARE_BRACKET", "R_SQUARE_BRACKET", "ASSIGN", "RETURN", "NUMBER",
  "IDENT", "MULT", "DIV", "MOD", "ADD", "SUB", "LT", "LTE", "GT", "GTE",
  "EQ", "NEQ", "$accept", "Program", "Functions", "beginparam", "endparam",
  "Function", "$@1", "Declaration1", "Declaration", "Statement1",
  "identifier", "TYPE", "Statement", "assign_rule", "if_clause", "else_if",
  "If_rule", "while_key", "while_clause", "while_rule", "do_key",
  "do_check", "do_while_rule", "read_mult", "Read_in", "comma_mult",
  "write_rule", "Bool-Expr", "relation_exprr", "relation_expr",
  "Relation_Expr", "Comp", "expression", "expradd", "mul_expr",
  "multi_term", "term", "Term_1", "Normal", "Expression1", "var", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306
};
# endif

#define YYPACT_NINF -135

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-135)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
       0,   -27,    21,  -135,     0,  -135,  -135,  -135,    22,    42,
    -135,    28,    40,   102,    83,    84,    28,  -135,   105,    28,
      25,  -135,    28,  -135,  -135,    82,  -135,   108,    80,   115,
      86,    -7,   110,    18,  -135,   104,  -135,    85,    31,   -11,
      64,   118,    97,  -135,    -7,    -7,  -135,    18,    -7,  -135,
      -7,   111,  -135,  -135,  -135,   117,  -135,  -135,    34,    18,
    -135,    67,    31,    -9,   103,  -135,  -135,    41,    59,    52,
    -135,  -135,  -135,    -8,   -11,    96,   100,  -135,   -11,   -11,
    -135,    -7,    89,   119,    -2,   112,   113,    18,  -135,  -135,
       4,    35,    16,   -11,  -135,  -135,  -135,    18,    18,  -135,
    -135,  -135,  -135,  -135,  -135,   -11,   -11,   -11,  -135,   -11,
     -11,   -11,  -135,    98,   -11,  -135,   106,    31,  -135,   101,
    -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,   114,  -135,
    -135,  -135,   107,   109,   116,   103,  -135,  -135,    59,    59,
      52,    52,    52,    13,   120,   100,    99,   -11,  -135,  -135,
    -135,  -135,  -135,  -135,  -135,   -11,  -135,   121,  -135,   -11,
    -135,   122,  -135,  -135,   121,  -135
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       3,     0,     0,     2,     3,     7,     1,     4,     0,     0,
       5,     9,    14,     0,     0,     0,     0,     6,     0,     9,
       0,    15,     9,    10,    16,     0,    11,     0,     0,     0,
       0,     0,     0,     0,    32,     0,    24,     0,     0,     0,
       0,     0,     0,    18,     0,     0,    19,     0,     0,    20,
       0,     0,    21,    22,    23,     0,    53,    54,     0,     0,
      77,    81,     0,     0,    46,    48,    50,     0,    63,    67,
      71,    76,    35,    40,     0,    81,    43,    25,     0,     0,
       8,    13,     0,     0,     0,     0,     0,     0,    17,    51,
       0,     0,     0,     0,    73,    72,    28,     0,     0,    58,
      60,    59,    61,    56,    57,     0,     0,     0,    62,     0,
       0,     0,    66,     0,     0,    41,     0,     0,    45,     0,
      26,    12,    30,    29,    31,    33,    34,    36,    37,    55,
      78,    75,    79,     0,     0,    47,    49,    52,    63,    63,
      67,    67,    67,    40,     0,    43,     0,     0,    74,    82,
      64,    65,    68,    69,    70,     0,    38,    40,    44,     0,
      80,     0,    42,    27,    40,    39
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -135,  -135,   137,  -135,  -135,  -135,  -135,    43,  -135,   -40,
     128,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,  -135,
    -135,  -135,  -135,  -134,  -135,     1,  -135,   -45,    48,    49,
      90,  -135,   -39,   -29,     5,   -64,   -13,  -135,   -37,     2,
    -135
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     2,     3,    11,    18,     4,     8,    13,    14,    41,
      15,    26,    42,    43,    44,    45,    46,    47,    48,    49,
      50,    51,    52,   115,    53,   118,    54,    63,    64,    65,
      66,   105,    67,   108,    68,   112,    69,    94,    70,   133,
      71
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      77,    76,    84,     1,    82,    83,    96,    33,    85,   156,
      86,    34,    35,     5,    90,    36,    37,    38,   125,    97,
      91,     6,    74,   162,   113,    95,    97,   114,    60,    61,
     165,    39,    97,    40,    62,   116,    24,    25,   129,   119,
     120,   121,   128,    56,    57,   113,    10,    58,   155,    74,
     131,    59,     9,   132,   134,    60,    61,    60,    61,    56,
      57,    62,    23,    62,    74,    27,   137,    59,    12,   130,
      60,    75,    16,    60,    61,   144,   152,   153,   154,    62,
     145,    99,   100,   101,   102,   103,   104,    99,   100,   101,
     102,   103,   104,   109,   110,   111,   140,   141,   142,    78,
      92,    79,    93,   106,   107,   122,   123,    17,   132,   150,
     151,   138,   139,    19,    22,    20,   161,    28,    29,    30,
     163,    31,    32,    55,    72,    73,    80,    81,    88,    87,
      98,    93,   117,   126,   127,   124,   159,   146,   143,   147,
     130,     7,    97,   148,    21,   135,   158,   136,    89,   160,
       0,     0,   149,   113,     0,     0,   157,     0,   164
};

static const yytype_int16 yycheck[] =
{
      39,    38,    47,     3,    44,    45,    15,    14,    48,   143,
      50,    18,    19,    40,    59,    22,    23,    24,    20,    28,
      59,     0,    33,   157,    32,    62,    28,    35,    39,    40,
     164,    38,    28,    40,    45,    74,    11,    12,    34,    78,
      79,    81,    87,    25,    26,    32,     4,    29,    35,    33,
      34,    33,    30,    92,    93,    39,    40,    39,    40,    25,
      26,    45,    19,    45,    33,    22,   105,    33,    40,    34,
      39,    40,    32,    39,    40,   114,   140,   141,   142,    45,
     117,    46,    47,    48,    49,    50,    51,    46,    47,    48,
      49,    50,    51,    41,    42,    43,   109,   110,   111,    35,
      33,    37,    35,    44,    45,    16,    17,     5,   147,   138,
     139,   106,   107,    30,     9,    31,   155,    35,    10,    39,
     159,     6,    36,    13,    20,    40,     8,    30,    11,    18,
      27,    35,    32,    21,    21,    16,    37,    36,    40,    32,
      34,     4,    28,    34,    16,    97,   145,    98,    58,   147,
      -1,    -1,    36,    32,    -1,    -1,    36,    -1,    36
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,    53,    54,    57,    40,     0,    54,    58,    30,
       4,    55,    40,    59,    60,    62,    32,     5,    56,    30,
      31,    62,     9,    59,    11,    12,    63,    59,    35,    10,
      39,     6,    36,    14,    18,    19,    22,    23,    24,    38,
      40,    61,    64,    65,    66,    67,    68,    69,    70,    71,
      72,    73,    74,    76,    78,    13,    25,    26,    29,    33,
      39,    40,    45,    79,    80,    81,    82,    84,    86,    88,
      90,    92,    20,    40,    33,    40,    90,    84,    35,    37,
       8,    30,    61,    61,    79,    61,    61,    18,    11,    82,
      79,    84,    33,    35,    89,    90,    15,    28,    27,    46,
      47,    48,    49,    50,    51,    83,    44,    45,    85,    41,
      42,    43,    87,    32,    35,    75,    84,    32,    77,    84,
      84,    61,    16,    17,    16,    20,    21,    21,    79,    34,
      34,    34,    84,    91,    84,    80,    81,    84,    86,    86,
      88,    88,    88,    40,    84,    90,    36,    32,    34,    36,
      85,    85,    87,    87,    87,    35,    75,    36,    77,    37,
      91,    84,    75,    84,    36,    75
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    52,    53,    54,    54,    55,    56,    58,    57,    59,
      59,    60,    61,    61,    62,    62,    63,    63,    64,    64,
      64,    64,    64,    64,    64,    64,    65,    65,    66,    67,
      68,    68,    69,    70,    71,    72,    73,    74,    75,    75,
      75,    76,    76,    77,    77,    78,    79,    79,    80,    80,
      81,    81,    82,    82,    82,    82,    83,    83,    83,    83,
      83,    83,    84,    85,    85,    85,    86,    87,    87,    87,
      87,    88,    88,    88,    89,    89,    90,    90,    90,    91,
      91,    92,    92
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     0,     2,     1,     1,     0,    13,     0,
       3,     3,     3,     2,     1,     3,     1,     6,     1,     1,
       1,     1,     1,     1,     1,     2,     3,     6,     3,     3,
       3,     3,     1,     3,     3,     2,     3,     3,     3,     6,
       0,     3,     6,     0,     3,     3,     1,     3,     1,     3,
       1,     2,     3,     1,     1,     3,     1,     1,     1,     1,
       1,     1,     2,     0,     3,     3,     2,     0,     3,     3,
       3,     1,     2,     2,     3,     2,     1,     1,     3,     1,
       3,     1,     4
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 5:
#line 74 "mini_l.y" /* yacc.c:1646  */
    { go_to_param_table=true;}
#line 1411 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 77 "mini_l.y" /* yacc.c:1646  */
    { go_to_param_table=false;}
#line 1417 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 80 "mini_l.y" /* yacc.c:1646  */
    {function_table.push_back(strdup((yyvsp[0].sval))); cout << "func " << strdup((yyvsp[0].sval)) << endl;}
#line 1423 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 81 "mini_l.y" /* yacc.c:1646  */
    {
			for(unsigned int j=0;j<symbol_table.size();j++)
			{
				if(symbol_type.at(j)=="INTEGER")
					cout<<". "<<symbol_table.at(j)<<endl;

				else
					cout<<".[] "<<symbol_table.at(j)<<", "<<symbol_type.at(j)<<endl;
			}
            		while(!parameter_table.empty())
            		{
                		cout<<"= "<<parameter_table.front()<<", $"<<param_val<<endl;
                		parameter_table.erase(parameter_table.begin());
                		param_val++;
            		}
            		//STATEMENT PRINT
            		for(unsigned i=0;i<mil_vector.size();i++)
                		cout<<mil_vector.at(i)<<endl;
            		cout<<"endfunc"<<endl;
            		mil_vector.clear();
            		symbol_table.clear();
            		symbol_type.clear();
            		parameter_table.clear();
           		param_val=0;
		}
#line 1453 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 121 "mini_l.y" /* yacc.c:1646  */
    {
					symbol_table.push_back(std::string("_") + strdup((yyvsp[0].sval)));
            			if(go_to_param_table)
                			parameter_table.push_back(std::string("_") + strdup((yyvsp[0].sval)));
				}
#line 1463 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 127 "mini_l.y" /* yacc.c:1646  */
    {
					symbol_table.push_back(std::string("_") + strdup((yyvsp[-2].sval)));
					symbol_type.push_back("INTEGER");
				}
#line 1472 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 134 "mini_l.y" /* yacc.c:1646  */
    { 
				symbol_type.push_back("INTEGER");
			}
#line 1480 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 138 "mini_l.y" /* yacc.c:1646  */
    {
				stringstream ss;
				ss << (yyvsp[-3].num_val);
				string s = ss.str();
				symbol_type.push_back(s);
			}
#line 1491 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 153 "mini_l.y" /* yacc.c:1646  */
    {
					if (!loop_label.empty())
            		{
						if(loop_label.back().at(0).at(0)=='d')
                    			mil_vector.push_back(":= "+ loop_label.back().at(1)); 
                		else
                    			mil_vector.push_back(":= "+ loop_label.back().at(0));
            		}
        		}
#line 1505 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 165 "mini_l.y" /* yacc.c:1646  */
    {
            		mil_vector.push_back("ret "+oper_vector.back());
            		oper_vector.pop_back();
        		}
#line 1514 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 172 "mini_l.y" /* yacc.c:1646  */
    {
            		string var = std::string("_") + strdup((yyvsp[-2].sval));
            		mil_vector.push_back("= " + var + ", " + oper_vector.back() );
            		oper_vector.pop_back();
        		}
#line 1524 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 178 "mini_l.y" /* yacc.c:1646  */
    {
            		string var = std::string("_") + strdup((yyvsp[-5].sval));
            		string array_result_expression = oper_vector.back();
            		oper_vector.pop_back();
            		string array_expression = oper_vector.back();
            		oper_vector.pop_back();
            		mil_vector.push_back(std::string("[]= _") + strdup((yyvsp[-5].sval))+", " + array_expression + ", " + array_result_expression); 
        		}
#line 1537 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 190 "mini_l.y" /* yacc.c:1646  */
    {
            		label_count++;    
            		m.str("");
            		m.clear();     
            		m<<label_count;
            		string label_1 = "if_condition_true_"+m.str(); 
            		string label_2 = "if_condition_false_"+m.str();
            		string label_3 = "end_if_"+m.str();
            		vector<string> temp;        //temp label vector
            		temp.push_back(label_1);    
            		temp.push_back(label_2);    
           			temp.push_back(label_3);
            		if_label.push_back(temp);   //pushing temp vector onto if label
            		mil_vector.push_back("?:= "+if_label.back().at(0)+", "+oper_vector.back());
            		oper_vector.pop_back();
            		mil_vector.push_back(":= "+if_label.back().at(1)); 
            		mil_vector.push_back(": "+if_label.back().at(0));    
				}
#line 1560 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 211 "mini_l.y" /* yacc.c:1646  */
    {
               		mil_vector.push_back(":= "+if_label.back().at(2));
                	mil_vector.push_back(": "+if_label.back().at(1));
            	}
#line 1569 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 218 "mini_l.y" /* yacc.c:1646  */
    {
            		mil_vector.push_back(": "+if_label.back().at(1));
            		if_label.pop_back();
        		}
#line 1578 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 223 "mini_l.y" /* yacc.c:1646  */
    {
           			mil_vector.push_back(": "+if_label.back().at(2));
           			if_label.pop_back();
        		}
#line 1587 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 230 "mini_l.y" /* yacc.c:1646  */
    {
            	label_count++;
            	m.str("");
            	m.clear();      
            	m<<label_count;
            	string label_1 = "while_loop_"+m.str();
            	string label_2 = "conditional_true_"+m.str();
            	string label_3 = "conditional_false_"+m.str();
            	vector<string> temp;        //temp label vector
            	temp.push_back(label_1);    
            	temp.push_back(label_2);  
            	temp.push_back(label_3);  
            	loop_label.push_back(temp); 
            	mil_vector.push_back(": "+loop_label.back().at(0));
            }
#line 1607 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 248 "mini_l.y" /* yacc.c:1646  */
    {
                mil_vector.push_back("?:= "+loop_label.back().at(1)+", "+oper_vector.back());
                oper_vector.pop_back();
                mil_vector.push_back(":= "+loop_label.back().at(2));
                mil_vector.push_back(": "+loop_label.back().at(1));
            }
#line 1618 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 257 "mini_l.y" /* yacc.c:1646  */
    {
            	mil_vector.push_back(":= "+loop_label.back().at(0));
            	mil_vector.push_back(": "+loop_label.back().at(2));
            	loop_label.pop_back();
        	}
#line 1628 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 265 "mini_l.y" /* yacc.c:1646  */
    {
            label_count++; 
            m.str("");
            m.clear();     
            m<<label_count;
            string label_1 = "do_while_loop_"+m.str();
            string label_2 = "do_while_conditional_check"+m.str();
            vector <string> temp;
            temp.push_back(label_1);
            temp.push_back(label_2);
            loop_label.push_back(temp);
            mil_vector.push_back(": "+label_1);
        }
#line 1646 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 281 "mini_l.y" /* yacc.c:1646  */
    {
            	mil_vector.push_back(": "+ loop_label.back().at(1));
          }
#line 1654 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 287 "mini_l.y" /* yacc.c:1646  */
    {
            			mil_vector.push_back("?:= "+ loop_label.back().at(0)+", "+oper_vector.back());
            			oper_vector.pop_back();
            			loop_label.pop_back();
        			}
#line 1664 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 38:
#line 295 "mini_l.y" /* yacc.c:1646  */
    {
                string var = std::string("_") + strdup((yyvsp[-1].sval));
                read_queue.push(std::string(".< _") + strdup((yyvsp[-1].sval)));

            }
#line 1674 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 302 "mini_l.y" /* yacc.c:1646  */
    {
                string var = std::string("_") + strdup((yyvsp[-4].sval));
                grab_variables();  
                read_queue.push(".< "+new_temp_var);
                read_queue.push(std::string("[]= _") + strdup((yyvsp[-4].sval)) + ", " + oper_vector.back() + ", " + new_temp_var);
                oper_vector.pop_back();
            }
#line 1686 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 313 "mini_l.y" /* yacc.c:1646  */
    {                                      
            	string var = std::string("_") + strdup((yyvsp[-1].sval));            
            	mil_vector.push_back(std::string(".< _") + strdup((yyvsp[-1].sval)));
            	while(!read_queue.empty())
            	{
                	mil_vector.push_back(read_queue.top());
                	read_queue.pop();
            	}
        	}
#line 1700 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 323 "mini_l.y" /* yacc.c:1646  */
    {
            	string var = std::string("_") + strdup((yyvsp[-4].sval));
            	grab_variables();      
            	mil_vector.push_back(std::string(".< ") +new_temp_var);
            	mil_vector.push_back(std::string("[]= _") + strdup((yyvsp[-4].sval))+ ", " + oper_vector.back() + ", " + new_temp_var);
            	oper_vector.pop_back();
            	while(!read_queue.empty())
            	{
                	mil_vector.push_back(read_queue.top());
                	read_queue.pop();
            	}
        	}
#line 1717 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 342 "mini_l.y" /* yacc.c:1646  */
    {
            		while(!oper_vector.empty())
            		{
            			string s= oper_vector.front();
                		oper_vector.erase(oper_vector.begin());
                		mil_vector.push_back(".> "+ s);
            		}
            		oper_vector.clear();
        		}
#line 1731 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 355 "mini_l.y" /* yacc.c:1646  */
    {
            		grab_variables();     
            		grab_operation = "|| "; 
            		grab_operators_frm_vector();  
			}
#line 1741 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 364 "mini_l.y" /* yacc.c:1646  */
    {
		 			grab_operation = "&& "; 
            		grab_variables(); 
					grab_operators_frm_vector();  
            	}
#line 1751 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 373 "mini_l.y" /* yacc.c:1646  */
    {
	    			grab_variables(); 
            		string op1 = oper_vector.back();
            		oper_vector.pop_back();        
           	        mil_vector.push_back("! "+new_temp_var+", "+op1); 
            		oper_vector.push_back(new_temp_var);
				}
#line 1763 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 383 "mini_l.y" /* yacc.c:1646  */
    {
					grab_variables();
					grab_operators_frm_vector(); 
				}
#line 1772 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 53:
#line 389 "mini_l.y" /* yacc.c:1646  */
    {
					grab_variables();             
	    			mil_vector.push_back("= "+new_temp_var+", 1");
            		oper_vector.push_back(new_temp_var);
				}
#line 1782 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 396 "mini_l.y" /* yacc.c:1646  */
    {
					grab_variables();             
	    			mil_vector.push_back("= "+new_temp_var+", 0"); 
            		oper_vector.push_back(new_temp_var);
				}
#line 1792 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 404 "mini_l.y" /* yacc.c:1646  */
    {grab_operation = "== ";}
#line 1798 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 405 "mini_l.y" /* yacc.c:1646  */
    {grab_operation = "!= ";}
#line 1804 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 406 "mini_l.y" /* yacc.c:1646  */
    {grab_operation = "< ";}
#line 1810 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 59:
#line 407 "mini_l.y" /* yacc.c:1646  */
    {grab_operation = "> ";}
#line 1816 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 60:
#line 408 "mini_l.y" /* yacc.c:1646  */
    {grab_operation = "<= ";}
#line 1822 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 61:
#line 409 "mini_l.y" /* yacc.c:1646  */
    {grab_operation = ">= ";}
#line 1828 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 64:
#line 418 "mini_l.y" /* yacc.c:1646  */
    {
			grab_operation = "+ "; 
            grab_variables();  
           	grab_operators_frm_vector(); 	
        }
#line 1838 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 65:
#line 424 "mini_l.y" /* yacc.c:1646  */
    {
			grab_operation = "- "; 
            grab_variables();             
	    	grab_operators_frm_vector();  
        }
#line 1848 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 68:
#line 436 "mini_l.y" /* yacc.c:1646  */
    {
			grab_operation = "* "; 
           	grab_variables(); 
	    	grab_operators_frm_vector();       	
		}
#line 1858 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 69:
#line 444 "mini_l.y" /* yacc.c:1646  */
    {
			grab_operation = "/ "; 
            grab_variables();  
            grab_operators_frm_vector(); 
		}
#line 1868 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 70:
#line 452 "mini_l.y" /* yacc.c:1646  */
    {
			grab_operation = "% ";
            grab_variables(); 
			grab_operators_frm_vector(); 
	   	}
#line 1878 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 71:
#line 459 "mini_l.y" /* yacc.c:1646  */
    { }
#line 1884 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 72:
#line 461 "mini_l.y" /* yacc.c:1646  */
    {
 		    		grab_variables();                    
                    mil_vector.push_back("- "+ new_temp_var + ", 0, " +oper_vector.back());    
                    oper_vector.pop_back(); 
                    oper_vector.push_back(new_temp_var); 

                }
#line 1896 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 73:
#line 469 "mini_l.y" /* yacc.c:1646  */
    {
                    grab_variables();                     
		    		mil_vector.push_back(std::string("call ") + strdup((yyvsp[-1].sval)) + ", " + new_temp_var);
                    oper_vector.push_back(new_temp_var); 
                }
#line 1906 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 74:
#line 477 "mini_l.y" /* yacc.c:1646  */
    {
                    while(!param_queue.empty())
                    {
                        mil_vector.push_back("param "+param_queue.top());
                        param_queue.pop();
                    }
                }
#line 1918 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 75:
#line 484 "mini_l.y" /* yacc.c:1646  */
    {}
#line 1924 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 76:
#line 489 "mini_l.y" /* yacc.c:1646  */
    {
                    grab_variables();  
                    string op1=oper_vector.back();       
                    if(op1.at(0)=='[') 
                        mil_vector.push_back("=[] "+new_temp_var+", "+op1.substr(3,op1.length()-3));
                    else 
                        mil_vector.push_back("= "+ new_temp_var+", "+oper_vector.back());    
                    oper_vector.pop_back(); 
                    oper_vector.push_back(new_temp_var);
                }
#line 1939 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 77:
#line 500 "mini_l.y" /* yacc.c:1646  */
    {
                    grab_variables();  
                    stringstream ss;
                    ss << (yyvsp[0].num_val);
                    mil_vector.push_back("= "+ new_temp_var +", "+ ss.str());
                    oper_vector.push_back(new_temp_var);
                }
#line 1951 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 79:
#line 511 "mini_l.y" /* yacc.c:1646  */
    {
                    param_queue.push(oper_vector.back());
                    oper_vector.pop_back();
                }
#line 1960 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 80:
#line 516 "mini_l.y" /* yacc.c:1646  */
    {
                    param_queue.push(oper_vector.back());
                    oper_vector.pop_back();
                }
#line 1969 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 81:
#line 523 "mini_l.y" /* yacc.c:1646  */
    {
                    string var = std::string("_") + strdup((yyvsp[0].sval)); 
                    oper_vector.push_back(var);
                }
#line 1978 "mini_l.tab.c" /* yacc.c:1646  */
    break;

  case 82:
#line 528 "mini_l.y" /* yacc.c:1646  */
    {
                    string op1 = oper_vector.back();
                    oper_vector.pop_back();
                    string var = std::string("_") + strdup((yyvsp[-3].sval));
                    oper_vector.push_back("[] " + var + ", " + op1);
                }
#line 1989 "mini_l.tab.c" /* yacc.c:1646  */
    break;


#line 1993 "mini_l.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 536 "mini_l.y" /* yacc.c:1906  */

void grab_variables() {
            m.str("");
            m.clear();   
            m<<temp_count;   
            temp_count++;
            new_temp_var=std::string("_temp_")+ m.str();  
            symbol_table.push_back(new_temp_var);  
            symbol_type.push_back("INTEGER"); 
}

void grab_operators_frm_vector(){
	    string op2 = oper_vector.back();
            oper_vector.pop_back();
            string op1 = oper_vector.back();
            oper_vector.pop_back();
            mil_vector.push_back(grab_operation + new_temp_var + ", "+op1+", "+op2);    
            oper_vector.push_back(new_temp_var);
}

void yyerror(const char* s)
{
   cout << "** Line " << linenum << ", position " << col << ": " << s << endl; 
}

int main(int argc, char **argv) {
   if (argc > 1 && (freopen(argv[1], "r", stdin) == NULL)) {
      cerr << argv[0] << ": File " << argv[1] << " cannot beopened.\n"; 
 	exit(1);  
   }
   yyparse(); 
   return 0;
}

