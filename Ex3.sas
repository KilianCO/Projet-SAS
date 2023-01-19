/* Exo 3 AFD */

proc import out= Train(keep = STG SCG STR LPR PEG UNS)
    datafile = "U:\Master 2\Data Mining\Projet\Data_User_Modeling_Dataset_Hamdi Tolga KAHRAMAN.xls"
	DBMS=XLS replace;
    sheet = "Training_Data";
    getnames = yes;
run;

proc import out= Test(keep = STG SCG STR LPR PEG UNS)
    datafile = "U:\Master 2\Data Mining\Projet\Data_User_Modeling_Dataset_Hamdi Tolga KAHRAMAN.xls"
	DBMS=XLS replace;
    sheet = "Test_Data";
    getnames = yes;
run;

proc print data = Train;
run;

proc print data = Test;
run;

proc discrim data = Train anova;
	class UNS;
	var STG SCG STR LPR PEG;   /* Toutes les variables ont l'air significative*/
run;

proc discrim data = Train crossvalidate anova;
	class UNS;
	var STG SCG STR LPR PEG;
run;

proc discrim data = Train method = npar r = 3 crossvalidate kernel = normal;
	title "M�thode non param�trique des plus proches voisins";
	class UNS;
	var STG SCG STR LPR PEG;
run;

proc discrim data = Train method = npar k = 6 crossvalidate out = tab;
	class UNS;
	var STG SCG STR LPR PEG;
run;

/* Il faut choisir le meilleur mod�le en modifiant les param�tres (par exemple modifi� le noyau ou la m�thode ou le crossvalidate.... */
/* Ensuite on prends celui qui �tait le meilleur et on le fait avec le Test (Ci-dessous exemple si le meilleur mod�le est le dernier qu'on a essay� avec Train) */
/* Il faut demander � la prof si on doit recoller toutes les donn�es entre elle pour faire 80/20 ou laisser comme tel (je t'expliquerais si t'as pas compris)*/

proc discrim data = Test method = npar k = 6 crossvalidate out = tab;
	class UNS;
	var STG SCG STR LPR PEG;
run;
