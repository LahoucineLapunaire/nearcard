import "package:flutter/material.dart";

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff001f3f),
        title: const Text("Mentions Légales"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Politique de Confidentialité de l'Application NearCard",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "NearCard, soucieux des droits des individus, en particulier en ce qui concerne le traitement automatisé, et dans un souci de transparence envers ses clients, a mis en place une politique de confidentialité. Cette politique définit toutes les opérations de traitement, les finalités et les moyens d'action disponibles pour les individus afin qu'ils puissent exercer au mieux leurs droits.",
            ),
            Text(
              "Pour toute information supplémentaire sur la protection des données personnelles, nous vous invitons à consulter le site : https://www.cnil.fr/. La version de notre Politique de Confidentialité actuellement en ligne est la seule qui peut être appliquée pendant toute la période d'utilisation de l'application, jusqu'à ce qu'une nouvelle version la remplace. Dans la suite, nous ferons référence à :",
            ),
            Text(
              "Application : l'application NearCard à portée de main sur IOS ou Android.",
            ),
            Text(
              "'Utilisateur' : l'internaute visitant et utilisant les services de l'application",
            ),
            Text(
              "'Éditeur' signifie NearCard, l'entité légale responsable de la publication et du contenu de l'Application.",
            ),
            Text(
              "'Responsable de traitement' signifie la personne physique ou morale, l'autorité publique, l'institution ou tout autre organisme qui, seul ou conjointement avec d'autres, détermine les finalités et les moyens du traitement des données personnelles, y compris les mesures de sécurité relatives au fonctionnement et à l'utilisation de NearCard. Sauf indication contraire, le Responsable de Traitement est le Propriétaire de NearCard.",
            ),
            Text(
              "'Données personnelles' désigne toute information qui, directement, indirectement ou en combinaison avec d'autres informations - y compris un numéro d'identification personnel - permet l'identification ou l'identifiabilité d'une personne physique.",
            ),
            Text(
              "'Éditeur' signifie NearCard, l'entité légale responsable de la publication et du contenu de l'Application.",
            ),
            Text(
              "'Données d'utilisation' désigne les informations collectées automatiquement par NearCard (ou par des services tiers employés par NearCard), qui peuvent inclure les adresses IP ou les noms de domaine des ordinateurs utilisés par les utilisateurs qui utilisent NearCard, les adresses des Identifiants de Ressources Uniformes (URI), l'heure de la demande, la méthode utilisée pour soumettre la demande au serveur, la taille du fichier reçu en réponse, le code numérique indiquant le statut de la réponse du serveur (réussie, erreur, etc.), le pays d'origine, les caractéristiques du navigateur et du système d'exploitation utilisés par l'utilisateur, divers détails de temps par visite (par exemple, le temps passé sur chaque page de l'Application), et des détails sur le temps passé sur l'Application. Le pays d'origine, les caractéristiques du navigateur et du système d'exploitation utilisés par l'utilisateur, divers détails de temps par visite (par exemple, le temps passé sur chaque page de l'Application) et des détails sur le temps passé sur l'Application avec une référence particulière à la séquence des pages visitées, et d'autres paramètres relatifs au système d'exploitation ou à l'environnement informatique de l'Utilisateur.",
            ),
            SizedBox(height: 16),
            Text(
              "Article 1 - Accès à l'application",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "L'accès et l'utilisation de l'application sont strictement réservés à un usage personnel. Vous vous engagez à ne pas utiliser cette application et les informations ou données qu'elle contient à des fins commerciales, politiques ou publicitaires ou à des fins de sollicitation commerciale de quelque nature que ce soit, en particulier l'envoi de courriels non sollicités.",
            ),
            SizedBox(height: 16),
            Text(
              "Article 2 - Contenu de l'application",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Toutes les marques, photographies, textes, commentaires, illustrations, images, animées ou non, séquences vidéo, sons, ainsi que toutes les applications informatiques pouvant être utilisées pour faire fonctionner cette application, et plus généralement tous les éléments reproduits ou utilisés sur l'application sont protégés par les lois en vigueur en matière de propriété intellectuelle. Ils sont la propriété pleine et entière de l'éditeur ou de ses partenaires. Toute reproduction, représentation, utilisation ou adaptation, sous quelque forme que ce soit, de la totalité ou d'une partie de ces éléments, y compris les applications informatiques, sans l'accord préalable écrit de l'éditeur, est strictement interdite. Le fait pour l'éditeur de ne pas engager de poursuites dès qu'il a connaissance de l'utilisation non autorisée de ces éléments ne constitue pas une acceptation de cette utilisation et une renonciation aux poursuites.",
            ),
            SizedBox(height: 16),
            Text(
              "Article 3 - Gestion de l'application",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Pour la bonne gestion de l'application, l'éditeur peut à tout moment :",
            ),
            Text(
              "Suspendre, interrompre ou limiter l'accès à tout ou partie de l'application, réserver l'accès à l'application ou à certaines parties de l'application à une catégorie spécifique d'internautes.",
            ),
            Text(
              "Supprimer toute information susceptible de perturber le fonctionnement du site ou de contrevenir aux lois nationales ou internationales, ou aux règles de Netiquette (règles d'étiquette utilisées sur Internet).",
            ),
            Text(
              "Suspendre l'application pour effectuer des mises à jour.",
            ),
            SizedBox(height: 16),
            Text(
              "Article 4 - Responsabilités de l\'Éditeur et du Responsable de Traitement",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "La société individuelle Lahoucine LAPUNAIRE, immatriculée au Registre du Commerce et des Sociétés de Saint-Denis sous le numéro 951388073, dont le siège social est situé au 9 Rue Charles Fourier, 91011 Évry-Courcouronnes. Le directeur de la publication est Lahoucine LAPUNAIRE, Président : lahoucinel.freelance@gmail.com.",
            ),
            Text(
              "L'éditeur ne peut être tenu pour responsable de tout dysfonctionnement, panne, difficulté ou interruption de fonctionnement empêchant l'accès à l'application ou à l'une de ses fonctions. L'équipement que vous utilisez pour vous connecter à l'application relève de votre seule responsabilité. Vous devez prendre toutes les mesures appropriées pour protéger votre équipement et vos propres données, en particulier contre les attaques virales via Internet.",
            ),
            Text(
              "Vous êtes également seul responsable des sites, applications et données que vous consultez. L'éditeur ne peut être tenu pour responsable en cas de poursuites judiciaires à votre encontre :",
            ),
            Text(
              "Suite à l'utilisation de l'application ou de tout service accessible via Internet",
            ),
            Text(
              "En raison de votre non-respect de cette Politique de Confidentialité",
            ),
            Text(
              "L'éditeur n'est pas responsable des dommages qui vous sont causés, à des tiers et/ou à votre équipement en raison de votre connexion à l'application et vous renoncez à toute action à son encontre en conséquence. Si l'éditeur est l'objet de procédures amiables ou judiciaires en raison de votre utilisation de l'application, il peut engager une action à votre encontre afin d'obtenir réparation de l'ensemble des dommages, sommes, condamnations et frais qui pourraient découler de ces procédures.",
            ),
            SizedBox(height: 16),
            Text(
              "Article 5 - Liens hypertextes",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "La création par les utilisateurs de liens hypertextes vers tout ou partie de l'application est autorisée par l'éditeur. Tout lien doit être retiré sur simple demande de l'éditeur. L'éditeur n'est pas responsable des informations publiées et accessibles via un lien hypertexte publié sur l'application. L'éditeur n'a aucun droit sur le contenu d'un tel lien.",
            ),
            SizedBox(height: 16),
            Text(
              "Article 6 - Collecte et protection des données",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Vos données sont collectées par le propriétaire de l\'application. Les données personnelles signifient toute information relative à une personne physique identifiée ou identifiable (personne concernée). Une personne identifiable est une personne qui peut être identifiée, directement ou indirectement, en particulier par référence à un nom, un numéro d\'identification ou un ou plusieurs facteurs spécifiques à son identité physique, physiologique, génétique, mentale, économique, culturelle ou sociale.",
            ),
            Text(
              "Les informations personnelles qui peuvent être collectées sur l\'application sont utilisées par l\'éditeur pour la gestion des relations avec vous, et si nécessaire pour le traitement de vos commandes. Les données personnelles qui peuvent être collectées sont les suivantes :",
            ),
            Text(
              "Nom et prénom",
            ),
            Text(
              "Adresse postale",
            ),
            Text(
              "Adresse e-mail",
            ),
            Text(
              "Numéro de téléphone",
            ),
            Text(
              "Pour plus d'informations, veuillez vous référer aux tableaux de l'article 10.2 des conditions générales d'utilisation.",
            ),
            SizedBox(height: 16),
            Text(
              "Article 7 - Droits de l'utilisateur",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Conformément à la réglementation applicable aux données personnelles, les utilisateurs disposent des droits suivants :",
            ),
            Text(
              "Le droit d\'accès : vous pouvez exercer votre droit d\'accès à vos données personnelles en écrivant à l\'adresse e-mail suivante : moderation.nearcard@gmail.com. Dans ce cas, avant de mettre en œuvre ce droit, le propriétaire de l\'application peut demander une preuve de votre identité afin d'en vérifier l'exactitude.",
            ),
            Text(
              "Le droit de rectification : si les données personnelles détenues par le propriétaire de l\'application sont inexactes, vous pouvez demander que les informations soient mises à jour.",
            ),
            Text(
              "Le droit de suppression des données : vous pouvez demander la suppression de vos données personnelles conformément aux lois en vigueur sur la protection des données.",
            ),
            Text(
              "Le droit de limiter le traitement : vous pouvez demander au propriétaire de l\'application de limiter le traitement de vos données personnelles conformément au Règlement Général sur la Protection des Données (RGPD).",
            ),
            Text(
              "Le droit de s\'opposer au traitement des données : vous pouvez vous opposer au traitement de vos données conformément aux hypothèses énoncées dans le Règlement Général sur la Protection des Données (RGPD) :",
            ),
            Text(
              "Le droit à la portabilité : vous pouvez demander au propriétaire de l\'application de vous fournir les données personnelles que vous avez fournies afin qu\'elles puissent être transférées vers un autre site. Vous pouvez exercer ce droit en nous contactant à l\'adresse e-mail suivante : moderation.nearcard@gmail.com.",
            ),
            Text(
              "Toute demande doit être accompagnée d'une photocopie d'une pièce d'identité valide, signée, et doit mentionner l'adresse à laquelle l'éditeur de l'application peut contacter le demandeur. La réponse sera envoyée dans un délai d'un mois à compter de la réception de la demande. Ce délai d'un mois peut être prolongé de deux mois si la complexité de la demande et/ou le nombre de demandes le requièrent.",
            ),
            Text(
              "De plus, et depuis la loi n°2016-1321 du 7 octobre 2016, les personnes qui le souhaitent ont la possibilité d\'organiser le devenir de leurs données après leur décès. Pour en savoir plus sur le sujet, vous pouvez consulter l\'application web de la CNIL : https://www.cnil.fr/. Les utilisateurs peuvent également déposer une réclamation auprès de la CNIL sur l\'application de la CNIL : https://www.cnil.fr/. Nous vous recommandons de nous contacter d\'abord via moderation.nearcard@gmail.com avant de déposer une réclamation auprès de la CNIL, car nous sommes entièrement à votre disposition pour résoudre votre problème.",
            ),
            SizedBox(height: 16),
            Text(
              "Article 8 - Utilisation des données",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Les données personnelles collectées auprès des utilisateurs sont utilisées pour fournir et améliorer les services de l\'application et maintenir un environnement sécurisé. Plus spécifiquement, les utilisations sont les suivantes :",
            ),
            Text(
              "Accès de l\'utilisateur et utilisation de l\'application",
            ),
            Text(
              "Gestion du fonctionnement et optimisation de l'application",
            ),
            Text(
              "Mise en place du support utilisateur",
            ),
            Text(
              "Vérification, identification et authentification des données transmises par l\'utilisateur",
            ),
            Text(
              "Personnalisation des services en affichant des publicités basées sur l'historique de navigation de l'utilisateur, selon ses préférences",
            ),
            Text(
              "Prévention et détection de la fraude, gestion des logiciels malveillants et incidents de sécurité",
            ),
            Text(
              "Gestion des éventuels litiges avec les utilisateurs",
            ),
            Text(
              "Envoi d'informations commerciales et publicitaires, selon les préférences de l'utilisateur",
            ),
            SizedBox(height: 16),
            Text(
              "Article 9 - Politique de conservation des données",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Le propriétaire de l\'application conserve vos données afin de fournir ses services ou de vous apporter une assistance. Cela se fait dans la mesure raisonnablement nécessaire ou requise pour respecter les obligations légales ou réglementaires, résoudre les litiges, prévenir la fraude et les abus, ou faire respecter nos conditions générales. Nous pouvons également conserver certaines de vos informations si nécessaire, même après la fermeture de votre compte. Vos données sont conservées pendant la relation contractuelle et jusqu'à 12 mois après.",
            ),
            SizedBox(height: 16),
            Text(
              "Article 10 - Partage des données personnelles avec des tiers",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Les données personnelles peuvent être partagées avec des sociétés tierces exclusivement dans l\'Union européenne, dans les cas suivants :",
            ),
            Text(
              "Lorsque l\'utilisateur publie des informations accessibles au public, dans les espaces de commentaires gratuits de l\'application du propriétaire.",
            ),
            Text(
              "Lorsque l'utilisateur permet à une application tierce d'accéder à ses données.",
            ),
            Text(
              "Lorsque le propriétaire de l\'application utilise les services de prestataires de services pour fournir un support utilisateur, des services publicitaires et de paiement. Ces prestataires de services ont un accès limité aux données de l\'utilisateur afin de fournir ces services et sont contractuellement tenus de les utiliser conformément aux dispositions de la réglementation applicable à la protection des données personnelles.",
            ),
            Text(
              "Les données personnelles peuvent être partagées avec des sociétés tierces exclusivement dans l\'Union européenne, dans les cas suivants.",
            ),
            SizedBox(height: 16),
            Text(
              "Article 11 - Offres commerciales",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Vous pouvez recevoir des offres commerciales via nos campagnes d'e-mailing. Vous pouvez vous désabonner directement des e-mails en question en cliquant sur le lien \'Se désabonner\'. L'éditeur s'engage à sécuriser vos données.",
            ),
            Text(
              "Si, lors de l\'utilisation de l\'application, vous accédez à des données personnelles, vous devez vous abstenir de toute collecte, de toute utilisation non autorisée et de tout acte susceptible de constituer une atteinte à la vie privée ou à la réputation des individus. Vous pouvez signaler tout incident à l\'adresse suivante : moderation.nearcard. Les données sont conservées et utilisées pendant une durée conforme à la législation en vigueur.",
            ),
            SizedBox(height: 16),
            Text(
              "Article 12 - Loi applicable",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Cette Politique de Confidentialité est régie par le droit français et relève de la compétence des tribunaux du siège social de l\'éditeur, sous réserve d'une attribution de compétence spécifique découlant d'un texte légal ou réglementaire particulier. Pour toute question, information sur les produits présentés sur l'application, ou concernant l'application elle-même, vous pouvez laisser un message à l'adresse suivante : moderation.nearcard@gmail.com",
            ),
          ],
        ),
      ),
    );
    ;
  }
}
