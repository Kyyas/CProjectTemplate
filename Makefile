####################################
#
#	Files to compile
#
################################

# Files pos #
FSRC			:=	./src/
LIB_FILE		:=	./lib
INCLUDE_FILE	:=	./include

# SRC #
SRC		:=	main.c	\


####################################
#
#	Files list
#
################################

_FILES	:=	$(addprefix $(FSRC), $(SRC))	\

########################################
#
#	Options / Settings
#
####################################

################
#
#	Makefiles
#
############

# Keep "my" at the bottom of the list
_MAKEFILES	:=	my	\

LIBS	:=	$(addprefix -l, $(_MAKEFILES))
MAKE_LINE	:=	--no-print-directory
#######

# Binary name #
NAME	:=	Example

# Run line #
RUN_LINE	:=
VA_LINE		:=	-s --leak-check=full --track-origins=yes

# Flags #
CFLAGS		+=	-Wall -I$(INCLUDE_FILE)
DFLAGS		+=	-g
LDFLAGS	+=	-L$(LIB_FILE) $(LIBS)

####################################
#
#	Colors
#
################################

#C_COMPILE is the most important color to modify
C_COMPILE	:=	\033[01;38;5;31m# color used on compile messages
C_DEFAULT	:=	\033[0;0m# default color 
C_VALGRIND	:=	\033[01;38;5;1m# color used when "make varun"
C_RUN		:=	\033[01;38;5;2m# color used when "make run"
C_CLEAN		:=	\033[01;38;5;220m# color used for clean messages
C_FCLEAN	:=	\033[01;38;5;222m# color used for fclean messages

####################################
#
#	Commands
#
################################

CC	=	/bin/gcc
VA	=	/bin/valgrind
ECHO	=	/bin/echo
FIND	=	/bin/find
RM		=	/bin/rm
MAKE	=	/bin/make

###########################################################
#
#	Makefile rules
#
#	you shouldn't change it
#
################################

# var #
OBJ	:=	$(_FILES:.c=.o)
CLEAR	:=	\033[2K

# rules #
all: $(NAME)

$(NAME):	$(OBJ)	make_all
	@$(CC) $(OBJ) -o $(NAME) $(LDFLAGS)
	@$(ECHO) -e "$(CLEAR)$(NAME) : $(C_COMPILE)OK$(C_DEFAULT)"

%.o:	%.c
	@$(CC) -o $@ -c $< $(CFLAGS)
	@$(ECHO) -ne "$(CLEAR)Compiled $< : $(C_COMPILE)OK$(C_DEFAULT)\r"

clean:	make_clean
	@$(FIND)	./$(FSRC) -name "*.o" -delete
	@$(RM) -f vgcore*
	@$(ECHO) -e "'.o' Deletion : $(C_CLEAN)DONE$(C_DEFAULT)"

fclean:	clean make_fclean
	@$(RM) -f $(NAME)
	@$(ECHO) -e "'$(NAME)' Deletion : $(C_FCLEAN)DONE$(C_DEFAULT)"

re:	fclean	all

alld:	CFLAGS += $(DFLAGS)
alld:	$(OBJ)	make_alld
	@$(CC) $(OBJ) -o $(NAME) $(LDFLAGS)
	@$(ECHO) -e "$(CLEAR)$(NAME) : $(C_COMPILE)OK$(C_DEFAULT)"

red:	fclean	alld

varun:	alld
	@$(ECHO) -e "$(C_VALGRIND)Valgrind output :$(C_DEFAULT)"
	@$(VA) $(VA_LINE) ./$(NAME) $(RUN_LINE)

run:	all
	@$(ECHO) -e "$(C_RUN)Run output :$(C_DEFAULT)"
	@./$(NAME) $(RUN_LINE)

# Makefiles related #
make_all:
	@for makefile in $(_MAKEFILES); do	\
	$(MAKE) $(MAKE_LINE) -C $(LIB_FILE)/$$makefile;	\
	done

make_clean:
	@for makefile in $(_MAKEFILES); do	\
	$(MAKE) $(MAKE_LINE) -C $(LIB_FILE)/$$makefile clean;	\
	done

make_fclean:
	@for makefile in $(_MAKEFILES); do	\
	$(MAKE) $(MAKE_LINE) -C $(LIB_FILE)/$$makefile fclean;	\
	done

make_alld:
	@for makefile in $(_MAKEFILES); do	\
	$(MAKE) $(MAKE_LINE) -C $(LIB_FILE)/$$makefile alld;	\
	done

.PHONY:	all	clean fclean re debug run
