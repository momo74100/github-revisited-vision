
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { FileText, Folder, Code } from "lucide-react";
import { Link } from "react-router-dom";

const Index = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-12">
          <h1 className="text-4xl font-bold text-gray-900 mb-4">
            Projet GitHub Revisité
          </h1>
          <p className="text-xl text-gray-600 max-w-2xl mx-auto">
            Une application moderne intégrant React et vtiger CRM pour une expérience utilisateur optimisée
          </p>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6 max-w-6xl mx-auto">
          <Card className="hover:shadow-lg transition-shadow">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Folder className="h-5 w-5 text-blue-600" />
                Structure des fichiers
              </CardTitle>
              <CardDescription>
                Explorez l'arborescence complète du projet
              </CardDescription>
            </CardHeader>
            <CardContent>
              <Link to="/file-structure">
                <Button className="w-full">
                  <FileText className="mr-2 h-4 w-4" />
                  Voir la structure
                </Button>
              </Link>
            </CardContent>
          </Card>

          <Card className="hover:shadow-lg transition-shadow">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Code className="h-5 w-5 text-green-600" />
                Code React
              </CardTitle>
              <CardDescription>
                Application moderne avec TypeScript et Tailwind
              </CardDescription>
            </CardHeader>
            <CardContent>
              <Button variant="outline" className="w-full">
                En cours de développement
              </Button>
            </CardContent>
          </Card>

          <Card className="hover:shadow-lg transition-shadow">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <FileText className="h-5 w-5 text-purple-600" />
                vtiger CRM
              </CardTitle>
              <CardDescription>
                Système CRM traditionnel en PHP
              </CardDescription>
            </CardHeader>
            <CardContent>
              <Button variant="outline" className="w-full">
                Analyse en cours
              </Button>
            </CardContent>
          </Card>
        </div>

        <div className="mt-16 text-center">
          <div className="bg-white rounded-lg shadow-md p-8 max-w-4xl mx-auto">
            <h2 className="text-2xl font-semibold mb-4">À propos de ce projet</h2>
            <p className="text-gray-600 leading-relaxed">
              Ce projet combine une application React moderne avec un système vtiger CRM existant. 
              L'objectif est de créer une interface utilisateur moderne tout en préservant les 
              fonctionnalités CRM existantes. Utilisez la navigation ci-dessus pour explorer 
              les différents aspects du projet.
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Index;
