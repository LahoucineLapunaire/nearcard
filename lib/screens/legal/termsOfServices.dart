import "package:flutter/material.dart";

class TermsOfServicesScreen extends StatelessWidget {
  const TermsOfServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff001f3f),
        title: const Text("Conditions d'utilisation"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Conditions d'utilisation de l'application mobile 'NearCard'",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "ARTICLE 1 - OBJET DES CONDITIONS GÉNÉRALES D'UTILISATION",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "L'objet des présentes conditions générales d'utilisation (ci-après dénommées les 'CGU') est de définir les règles régissant l'utilisation de l'application mobile 'NearCard' (ci-après dénommée 'l'Application') publiée par la société individuelle Lahoucine LAPUNAIRE, immatriculée au Registre du Commerce et des Sociétés de Saint-Denis sous le numéro 951388073, dont le siège social est situé au 9 Rue Charles Fourier, 91011 Évry-Courcouronnes. Le directeur de la publication est Lahoucine LAPUNAIRE, Président : lahoucinel.freelance@gmail.com",
            ),
            Text(
              "En installant l'Application sur votre terminal et/ou en y accédant, vous acceptez sans réserve l'intégralité de ces CGU et vous vous engagez à respecter les obligations qui vous incombent. Si vous n'acceptez pas les CGU ou si vous avez des réserves, veuillez ne pas utiliser l'Application.",
            ),
            Text(
              "Les CGU expriment l'accord complet entre vous et NearCard concernant votre utilisation de l'Application. NearCard se réserve le droit de modifier ces CGU en les mettant à jour à tout moment. La version des CGU applicable entre vous et NearCard au moment de votre connexion et de votre utilisation de l'Application. Nous vous recommandons donc de consulter régulièrement cette page.",
            ),
            SizedBox(height: 16),
            Text(
              "ARTICLE 3 - ACCÈS À L'APPLICATION",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Pour accéder à l'Application, vous devez disposer d'un appareil mobile et d'une connexion Internet. L'Application peut être téléchargée gratuitement depuis les plates-formes 'Apple Store' et 'Google Play Store' sur les terminaux mobiles suivants :",
            ),
            Text(
              "Téléphone portable Apple® iPhone® fonctionnant sous le système d'exploitation iOS sous iOS 10.0 ou supérieur - téléphone portable fonctionnant sous le système d'exploitation iOS sous iOS 10.0 ou supérieur - téléphone portable fonctionnant sous le système d'exploitation iOS sous iOS 10.0 ou supérieur",
            ),
            Text(
              "Système d'exploitation Android® Lollipop (API 21) minimum.",
            ),
            Text(
              "La version logicielle de l'Application peut être mise à jour de temps en temps pour ajouter de nouvelles fonctionnalités et services. Une fois l'Application installée sur votre appareil, connectez-vous simplement en utilisant votre adresse e-mail. Si vous êtes membre de NearCard, vous recevrez une notification dans votre boîte aux lettres pour valider votre compte. Si vous n'êtes pas encore membre de la communauté, veuillez nous contacter pour profiter de tous les avantages de NearCard : moderation.nearcard@gmail.com",
            ),
            SizedBox(height: 16),
            Text(
              "ARTICLE 4 - LICENCE D'UTILISATEUR",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "NearCard vous accorde un droit personnel d'utilisation de l'Application et de son contenu. Ce droit est accordé à titre personnel, non exclusif, révocable, non cessible, non transférable, mondial et gratuit, et uniquement pour l'utilisation de l'Application, à l'exclusion de toute autre fin. Il est strictement interdit d'accéder et/ou d'utiliser et/ou de tenter d'accéder ou d'utiliser les codes sources ou les objets de l'Application. Vous n'acquérez aucun droit de propriété intellectuelle sur l'Application ou sur son contenu, ni aucun autre droit que ceux conférés par les présentes CGU.",
            ),
            SizedBox(height: 16),
            Text(
              "ARTICLE 5 - DONNÉES PERSONNELLES",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Les données personnelles utilisées sont principalement votre numéro de téléphone, votre adresse e-mail, votre photo de profil, vos messages et vos publications. Vous pouvez exercer votre droit d'accès et de rectification en nous envoyant un e-mail à moderation.nearcard@gmail.com.",
            ),
            SizedBox(height: 16),
            Text(
              "ARTICLE 6 - PROPRIÉTÉ INTELLECTUELLE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "L'ensemble du contenu de l'Application est couvert par la législation française, européenne et internationale sur le droit d'auteur et la propriété intellectuelle. Tous les droits de reproduction et de représentation relatifs à l'Application sont réservés par NearCard, y compris toutes les représentations graphiques, iconographiques et photographiques, quelle que soit la zone de protection et que ces droits aient été enregistrés ou non. La reproduction et/ou la représentation de tout ou partie de l'Application, quel que soit le support, y compris tous les noms commerciaux, marques, logos, noms de domaine et autres signes distinctifs, est formellement interdite et constituerait une contrefaçon sanctionnée par le code de la propriété intellectuelle. Les mots NearCard et tous les logos sont des marques déposées de NearCard.",
            ),
            SizedBox(height: 16),
            Text(
              "ARTICLE 7 - DISPONIBILITÉ DE L'APPLICATION",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "L'Application est accessible en ligne 7 jours sur 7, 24 heures sur 24. Cependant, compte tenu de la complexité du réseau Internet et de l'afflux d'utilisateurs à certaines heures, NearCard ne garantit pas la continuité du service et ne peut être tenu responsable en cas d'incapacité temporaire d'accéder à tout ou partie de l'Application. Aucun droit à compensation NearCard se réserve le droit de cesser, sans préavis, sans compensation et à sa seule discrétion, de manière permanente ou temporaire, de fournir tout ou partie du Service ou des fonctionnalités du Site.@gmail.com.",
            ),
            SizedBox(height: 16),
            Text(
              "ARTICLE 8 - LIMITATION DE RESPONSABILITÉ - AUCUNE GARANTIE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "NearCard s'engage à mettre en œuvre tous les moyens nécessaires pour assurer le meilleur accès possible à l'Application. Vous êtes seul responsable de votre nom d'utilisateur. Vous acceptez de les garder confidentiels et de ne pas les transmettre à des tiers. Si vous constatez une utilisation non autorisée de votre compte, il vous incombe de signaler immédiatement à NearCard en écrivant à l'adresse suivante : moderation.nearcard@gmail.com En général, vous acceptez et reconnaissez que votre utilisation de l'Application, y compris les informations que vous diffusez, se fait sous votre seule et entière responsabilité. En utilisant l'Application, vous acceptez de ne pas agir de manière préjudiciable ou ayant pour effet de porter atteinte à l'image, aux intérêts ou aux droits de NearCard, de nuire ou de rendre l'Application inopérante. NearCard ne peut être tenue responsable et ne peut être tenue de vous indemniser pour tout dommage direct ou indirect résultant de l'indisponibilité de l'Application. à cet égard, elle ne peut être tenue pour responsable de tout dommage résultant de la perte, de la modification ou de l'utilisation frauduleuse de données, de la transmission accidentelle de virus ou d'autres éléments nuisibles, du comportement ou de la conduite d'un niveaux. Elle ne supporte aucune responsabilité pour (i) l'impossibilité d'accéder à l'Application, (ii) la mauvaise utilisation de l'Application (iii) la saturation du réseau Internet, (iv) les éventuels dysfonctionnements des terminaux mobiles utilisés par vous, (v) en cas de force majeure ou d'un fait indépendant de sa volonté.",
            ),
            SizedBox(height: 16),
            Text(
              "ARTICLE 9 - NON-RENONCIATION ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Le fait qu'une des parties ne profite pas d'une violation par l'autre partie de l'une des obligations visées dans les présentes CGU ne saurait être interprété pour l'avenir comme une renonciation à l'obligation en question.",
            ),
            SizedBox(height: 16),
            Text(
              "ARTICLE 10 - DROIT APPLICABLE - LITIGES ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Les présentes CGU sont régies par le droit français. Tout litige concernant l'Application ou l'interprétation des présentes CGU sera soumis au tribunal compétent de Lyon. ",
            ),
            SizedBox(height: 16),
            Text(
              "ARTICLE 11 - CONTACT ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Si vous avez des questions ou des commentaires concernant ces CGU, veuillez contacter NearCard en écrivant à l'adresse suivante : moderation.nearcard@gmail.com",
            ),
          ],
        ),
      ),
    );
  }
}
