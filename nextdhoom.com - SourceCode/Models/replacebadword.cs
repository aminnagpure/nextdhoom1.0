using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Text.RegularExpressions;
using System.Web;

namespace WebApplication13.Models
{
    public class commonFun
    {
        public virtual string ReplaceBadWords(string str)
        {
            try
            {
                if (!string.IsNullOrEmpty(str))
                {
                    //Dim pattern As String = "( *damn | *dyke | *fuck* | *shit* | @$$ | ahole  | amcik | andskota | anus  | arschloch | arse* | ash0le  | ash0les  | asholes  | ass  | Ass Monkey  | Assface  | assh0le  | assh0lez  | asshole  | assholes  | assholz  | assrammer | asswipe  | ayir | azzhole  | b!+ch | b!tch | b00b* | b00bs | b17ch | b1tch | bassterds  | bastard  | bastards  | bastardz  | basterds  | basterdz  | bi+ch | bi7ch | Biatch  | bitch  | bitch* | bitches  | Blow Job  | blowjob | boffing  | boiolas | bollock* | boobs | breasts | buceta | butt-pirate | butthole  | buttwipe  | c0ck  | c0cks  | c0k  | cabron | Carpet Muncher  | cawk  | cawks  | cazzo | chink | chraa | chuj | cipa | clit | clits | cnts  | cntz  | cock  | Cock* | cock-head  | cock-sucker  | cockhead  | cocks  | CockSucker  | crap  | cum  | cunt | cunt* | cunts  | cuntz  | d4mn | daygo | dego | dick  | dick* | dike* | dild0  | dild0s  | dildo  | dildos  | dilld0  | dilld0s  | dirsa | dominatricks  | dominatrics  | dominatrix  | dupa | dyke  | dziwka | ejackulate | ejakulate | Ekrem* | Ekto | enculer | enema  | f u c k  | f u c k e r  | faen | fag  | fag* | fag1t  | faget  | fagg1t  | faggit  | faggot  | fagit  | fags  | fagz  | faig  | faigs  | fanculo | fanny | fart  | fatass | fcuk | feces | feg | Felcher | ficken | fitt* | Flikker | flipping the bird  | foreskin | Fotze | Fu(* | fuck | fucker  | fuckin  | fucking  | fucks  | Fudge Packer  | fuk  | fuk* | Fukah  | Fuken  | fuker  | Fukin  | Fukk  | Fukkah  | Fukken  | Fukker  | Fukkin  | futkretzn | fux0r | g00k  | gay  | gayboy  | gaygirl  | gays  | gayz  | God-damned  | gook | guiena | h00r  | h0ar  | h0r | h0re  | h4x0r | hell | hells  | helvete | hoar  | hoer | hoer* | honkey | hoor  | hoore  | hore | Huevon | hui | injun | jackoff  | jap  | japs  | jerk-off  | jisim  | jism | jiss  | jizm  | jizz  | kanker* | kawk | kike | klootzak | knob  | knobs  | knobz  | knulle | kraut | kuk | kuksuger | kunt  | kunts  | kuntz  | Kurac | kurwa | kusi* | kyrpa* | l3i+ch | l3itch | Lesbian  | lesbo | Lezzian  | Lipshits  | Lipshitz  | mamhoon | masochist  | masokist  | massterbait  | masstrbait  | masstrbate  | masterbaiter  | masterbat* | masterbat3 | masterbate  | masterbates  | masturbat* | masturbate | merd* | mibun | mofo | monkleigh | Motha Fucker  | Motha Fuker  | Motha Fukkah  | Motha Fukker  | Mother Fucker  | Mother Fukah  | Mother Fuker  | Mother Fukkah  | Mother Fukker  | mother-fucker  | motherfucker | mouliewop | muie | mulkku | muschi | Mutha Fucker  | Mutha Fukah  | Mutha Fuker  | Mutha Fukkah  | Mutha Fukker  | n1gr  | nastt  | nazi | nazis | nepesaurio | nigga | nigger | nigger* | nigger;  | nigur;  | niiger;  | niigr;  | nutsack | orafis  | orgasim;  | orgasm  | orgasum  | oriface  | orifice  | orifiss  | orospu | p0rn | packi  | packie  | packy  | paki  | pakie  | paky  | paska* | pecker  | peeenus  | peeenusss  | peenus  | peinus  | pen1s  | penas  | penis  | penis-breath  | penus  | penuus  | perse | Phuc  | Phuck  | Phuk  | Phuker  | Phukker  | picka | pierdol* | pillu* | pimmel | pimpis | piss* | pizda | polac  | polack  | polak  | Poonani  | poontsee | poop | porn | pr0n | pr1c  | pr1ck  | pr1k  | preteen | pula | pule | pusse  | pussee  | pussy  | puta | puto | puuke  | puuker  | qahbeh | queef* | queer  | queers  | queerz  | qweers  | qweerz  | qweir  | rautenberg | recktum  | rectum  | retard  | s.o.b. | sadist  | scank  | schaffer | scheiss* | schlampe | schlong  | schmuck | screw | screwing  | scrotum | semen  | sex  | sexy  | sh!+ | Sh!t  | sh!t* | sh1t  | sh1ter  | sh1ts  | sh1tter  | sh1tz  | sharmuta | sharmute | shemale | shi+ | shipal | shit | shits  | shitter  | Shitty  | Shity  | shitz  | shiz | Shyt  | Shyte  | Shytty  | Shyty  | skanck  | skank  | skankee  | skankey  | skanks  | Skanky  | skribz | skurwysyn | slut | sluts  | Slutty  | slutz  | smut | son-of-a-bitch  | sphencter | spic | spierdalaj | splooge | suka | teets | teez | testical | testicle | testicle* | tit  | tits | titt | titt* | turd  | twat | va1jina  | vag1na  | vagiina  | vagina  | vaj1na  | vajina  | vittu | vullva  | vulva  | w00se | w0p  | wank | wank* | wetback* | wh00r  | wh0re  | whoar | whore | wichser | wop* | xrated  | xxx | yed | zabourah )"
                   // string pattern = "(damn|dyke|fuck|shit|ahole|amcik|andskota|anus|arschloch|arse|ash0le|ash0les|asholes|ass|AssMonkey|Assface|assh0le|assh0lez|asshole|assholes|assholz|assrammer|asswipe|ayir|azzhole|bassterds|bastard|bastards|bastardz|basterds|basterdz|Biatch|bitch|bitch|bitches|BlowJob|blowjob|boffing|boiolas|bollock|boobs|breasts|buceta|butt-pirate|butthole|buttwipe|c0ck|c0cks|c0k|cabron|CarpetMuncher|cawk|cawks|cazzo|chink|chraa|chuj|cipa|clit|clits|cnts|cntz|cock|Cock|cock-head|cock-sucker|cockhead|cocks|CockSucker|crap|cum|cunt|cunt|cunts|cuntz|d4mn|daygo|dego|dick|dick|dike|fuck|fucker|fag|fart|fatass|fcuk|feces|feg|Felcher|ficken|fitt|Flikker|flippingthebird|foreskin|Fotze|fuck|fucker|fuckin|fucking|fucks|FudgePacker|fuk|Fukah|Fuken|fuker|Fukin|Fukk|Fukkah|Fukken|Fukker|Fukkin|guiena|hoor|lootzak|knob|knobs|knobz|knulle|kraut|kuk|kuksuger|kunt|kunts|kuntz|Kurac|kurwa|kusi|kyrpa|lesbo|Lezzian|Lipshits|Lipshitz|mamhoon|masochist|masokist|massterbait|masstrbait|masstrbate|masterbaiter|masterbat|masterbat3|masterbate|masterbates|masturbat|masturbate|merd|mibun|mofo|monkleigh|MothaFucker|MothaFuker|MothaFukkah|MothaFukker|MotherFucker|MotherFukah|MotherFuker|MotherFukkah|MotherFukker|mother-fucker|motherfucker|mouliewop|muie|mulkku|muschi|MuthaFucker|MuthaFukah|MuthaFuker|MuthaFukkah|MuthaFukker|n1gr|nastt|nazi|nazis|nepesaurio|nigga|nigger|nigger*|nigger;|nigur;|niiger;|niigr;|nutsack|orafis|orgasim;|orgasm|orgasum|oriface|orifice|orifiss|orospu|p0rn|packi|packie|packy|paki|pakie|paky|paska*|pecker|peeenus|peeenusss|peenus|peinus|pen1s|penas|penis|penis-breath|penus|penuus|perse|Phuc|Phuck|Phuk|Phuker|Phukker|picka|pierdol*|pillu*|pimmel|pimpis|piss*|pizda|polac|polack|polak|Poonani|poontsee|poop|porn|pr0n|pr1c|pr1ck|pr1k|preteen|pula|pule|pusse|pussee|pussy|puta|puto|puuke|puuker|qahbeh|queef*|queer|queers|queerz|qweers|qweerz|qweir|rautenberg|recktum|rectum|retard|s.o.b.|sadist|scank|schaffer|scheiss*|schlampe|schlong|schmuck|screw|screwing|scrotum|semen|sex|sexy|sh!+|Sh!t|sh!t*|sh1t|sh1ter|sh1ts|sh1tter|sh1tz|sharmuta|sharmute|shemale|shi+|shipal|shit|shits|shitter|Shitty|Shity|shitz|shiz|Shyt|Shyte|Shytty|Shyty|skanck|skank|skankee|skankey|skanks|Skanky|skribz|skurwysyn|slut|sluts|Slutty|slutz|smut|son-of-a-bitch|sphencter|spic|spierdalaj|splooge|suka|teets|teez|testical|testicle|testicle*|tit|tits|titt|titt*|turd|twat|va1jina|vag1na|vagiina|vagina|vaj1na|vajina|vittu|vullva|vulva|w00se|w0p|wank|wank*|wetback*|wh00r|wh0re|whoar|whore|wichser|wop*|xrated|xxx|yed|zabourah)";
                    string pattern = "(damn|dyke|fuck|shit|ahole|amcik|anal|Ass|Anal|Cock|penis|suck|)";
                    str = Regex.Replace(str, pattern, string.Empty, RegexOptions.IgnoreCase);
                    //
                }
                return str.Trim(); 
            }
            catch( Exception ex)
            {
                return ex.Message ;
            }   
        }

        public virtual string getip()
        {
            //get mac address
            NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
            String sMacAddress = string.Empty;
            foreach (NetworkInterface adapter in nics)
            {
                if (sMacAddress == String.Empty)// only return MAC Address from first card  
                {
                    IPInterfaceProperties properties = adapter.GetIPProperties();
                    sMacAddress = adapter.GetPhysicalAddress().ToString();
                }
            }
            // To Get IP Address


            string IPHost = Dns.GetHostName();
            string IP = Dns.GetHostEntry(IPHost).AddressList[0].ToString();

            return IP;

        }
    }
}