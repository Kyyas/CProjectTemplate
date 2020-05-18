###########################
#
#	Files to compile
#
######################

SRC	:=

###########################
#
#	Options / Settings
#
#######################

# Flags #
CFLAGS	+=	-Wall -Werror
DFLAGS	+=	-g

###########################
#
#	Colors
#
#######################

C_COMPILE	=	\033[01;38;5;29m# color used in compile message
C_DEFAULT	=	\033[0;0m# default color

###########################
#
#	Commands
#
#######################

CC	=	/bin/gcc
AR	=	/bin/ar
MV	=	/bin/mv
ECHO	=	/bin/echo
RM	=	/bin/rm

###########################################################
#
#	Makefile rules
#
#	you shouldn't change it
#
################################

# var #
OBJ		:=	$(SRC:.c=.o)
NAME	:=	$(addprefix lib, $(addsuffix .a, $(notdir $(CURDIR))))
CLEAR	:=	\033[2K

# rules #
all:	$(NAME)

$(NAME):	$(OBJ)
	@$(AR) rc $(NAME) $(OBJ)
	@$(MV) $(NAME) ../
	@$(ECHO) -e "$(CLEAR)$(NAME) : $(C_COMPILE)OK$(C_DEFAULT)"

%.o: %.c
	@$(CC) -o $@ -c $< $(CFLAGS)
	@$(ECHO) -ne "$(CLEAR)Compiled $< : $(C_COMPILE)OK$(C_DEFAULT)\r"

clean:
	@$(RM) -f *.o

fclean: clean
	@$(RM) -f ../$(NAME)

re:	fclean all

alld:	CFLAGS += $(DFLAGS)
alld:	all
