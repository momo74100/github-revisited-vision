
import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { ChevronRight, ChevronDown, Folder, File } from 'lucide-react';

interface FileNode {
  name: string;
  type: 'file' | 'folder';
  children?: FileNode[];
  path: string;
}

const FileStructure = () => {
  const [expandedFolders, setExpandedFolders] = useState<Set<string>>(new Set(['src']));

  // Structure des fichiers du projet
  const fileStructure: FileNode[] = [
    {
      name: 'src',
      type: 'folder',
      path: 'src',
      children: [
        {
          name: 'components',
          type: 'folder',
          path: 'src/components',
          children: [
            {
              name: 'ui',
              type: 'folder',
              path: 'src/components/ui',
              children: [
                { name: 'accordion.tsx', type: 'file', path: 'src/components/ui/accordion.tsx' },
                { name: 'alert.tsx', type: 'file', path: 'src/components/ui/alert.tsx' },
                { name: 'avatar.tsx', type: 'file', path: 'src/components/ui/avatar.tsx' },
                { name: 'badge.tsx', type: 'file', path: 'src/components/ui/badge.tsx' },
                { name: 'breadcrumb.tsx', type: 'file', path: 'src/components/ui/breadcrumb.tsx' },
                { name: 'button.tsx', type: 'file', path: 'src/components/ui/button.tsx' },
                { name: 'calendar.tsx', type: 'file', path: 'src/components/ui/calendar.tsx' },
                { name: 'card.tsx', type: 'file', path: 'src/components/ui/card.tsx' },
                { name: 'use-toast.ts', type: 'file', path: 'src/components/ui/use-toast.ts' },
              ]
            }
          ]
        },
        {
          name: 'pages',
          type: 'folder',
          path: 'src/pages',
          children: [
            { name: 'Index.tsx', type: 'file', path: 'src/pages/Index.tsx' },
            { name: 'NotFound.tsx', type: 'file', path: 'src/pages/NotFound.tsx' },
            { name: 'FileStructure.tsx', type: 'file', path: 'src/pages/FileStructure.tsx' },
          ]
        },
        {
          name: 'lib',
          type: 'folder',
          path: 'src/lib',
          children: [
            { name: 'utils.ts', type: 'file', path: 'src/lib/utils.ts' },
          ]
        },
        { name: 'App.tsx', type: 'file', path: 'src/App.tsx' },
        { name: 'main.tsx', type: 'file', path: 'src/main.tsx' },
        { name: 'vite-env.d.ts', type: 'file', path: 'src/vite-env.d.ts' },
      ]
    },
    {
      name: 'vtigercrm',
      type: 'folder',
      path: 'vtigercrm',
      children: [
        { name: 'index.php', type: 'file', path: 'vtigercrm/index.php' },
        { name: 'config.inc.php', type: 'file', path: 'vtigercrm/config.inc.php' },
        {
          name: 'modules',
          type: 'folder',
          path: 'vtigercrm/modules',
          children: [
            { name: 'Accounts', type: 'folder', path: 'vtigercrm/modules/Accounts' },
            { name: 'Contacts', type: 'folder', path: 'vtigercrm/modules/Contacts' },
            { name: 'Leads', type: 'folder', path: 'vtigercrm/modules/Leads' },
            { name: 'Users', type: 'folder', path: 'vtigercrm/modules/Users' },
          ]
        },
        {
          name: 'include',
          type: 'folder',
          path: 'vtigercrm/include',
          children: [
            { name: 'database', type: 'folder', path: 'vtigercrm/include/database' },
            { name: 'utils', type: 'folder', path: 'vtigercrm/include/utils' },
          ]
        },
        {
          name: 'themes',
          type: 'folder',
          path: 'vtigercrm/themes',
          children: [
            { name: 'softed', type: 'folder', path: 'vtigercrm/themes/softed' },
            { name: 'blue', type: 'folder', path: 'vtigercrm/themes/blue' },
          ]
        },
      ]
    },
    { name: 'index.html', type: 'file', path: 'index.html' },
    { name: 'package.json', type: 'file', path: 'package.json' },
    { name: 'vite.config.ts', type: 'file', path: 'vite.config.ts' },
    { name: 'tailwind.config.ts', type: 'file', path: 'tailwind.config.ts' },
    { name: 'tsconfig.json', type: 'file', path: 'tsconfig.json' },
  ];

  const toggleFolder = (path: string) => {
    const newExpanded = new Set(expandedFolders);
    if (newExpanded.has(path)) {
      newExpanded.delete(path);
    } else {
      newExpanded.add(path);
    }
    setExpandedFolders(newExpanded);
  };

  const renderFileNode = (node: FileNode, depth = 0) => {
    const isExpanded = expandedFolders.has(node.path);
    const indent = depth * 20;

    return (
      <div key={node.path}>
        <div 
          className={`flex items-center py-1 px-2 hover:bg-gray-100 cursor-pointer`}
          style={{ paddingLeft: `${indent + 8}px` }}
          onClick={() => node.type === 'folder' && toggleFolder(node.path)}
        >
          {node.type === 'folder' && (
            <Button variant="ghost" size="icon" className="h-4 w-4 p-0 mr-1">
              {isExpanded ? (
                <ChevronDown className="h-3 w-3" />
              ) : (
                <ChevronRight className="h-3 w-3" />
              )}
            </Button>
          )}
          {node.type === 'folder' ? (
            <Folder className="h-4 w-4 mr-2 text-blue-600" />
          ) : (
            <File className="h-4 w-4 mr-2 text-gray-600" />
          )}
          <span className={`text-sm ${node.type === 'folder' ? 'font-medium' : ''}`}>
            {node.name}
          </span>
        </div>
        
        {node.type === 'folder' && isExpanded && node.children && (
          <div>
            {node.children.map(child => renderFileNode(child, depth + 1))}
          </div>
        )}
      </div>
    );
  };

  return (
    <div className="min-h-screen bg-gray-50 p-6">
      <div className="max-w-4xl mx-auto">
        <div className="mb-6">
          <h1 className="text-3xl font-bold text-gray-900 mb-2">Structure des fichiers</h1>
          <p className="text-gray-600">
            Arborescence complète du projet incluant les fichiers React et vtiger CRM
          </p>
        </div>

        <div className="grid gap-6">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Folder className="h-5 w-5" />
                Arborescence du projet
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="bg-white border rounded-lg p-4 max-h-96 overflow-y-auto">
                {fileStructure.map(node => renderFileNode(node))}
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>Analyse de la structure</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <h3 className="font-semibold text-lg mb-2">Projet React (src/)</h3>
                <ul className="list-disc list-inside space-y-1 text-gray-700">
                  <li>Application React moderne avec TypeScript</li>
                  <li>Composants UI basés sur shadcn/ui et Radix UI</li>
                  <li>Routing avec React Router</li>
                  <li>Styling avec Tailwind CSS</li>
                  <li>Gestion d'état avec TanStack Query</li>
                </ul>
              </div>

              <div>
                <h3 className="font-semibold text-lg mb-2">vtiger CRM (vtigercrm/)</h3>
                <ul className="list-disc list-inside space-y-1 text-gray-700">
                  <li>Application PHP traditionnelle de CRM</li>
                  <li>Structure modulaire (Accounts, Contacts, Leads, Users)</li>
                  <li>Système de thèmes pour l'interface utilisateur</li>
                  <li>Fichiers de configuration et utilitaires</li>
                  <li>Architecture MVC classique en PHP</li>
                </ul>
              </div>

              <div>
                <h3 className="font-semibold text-lg mb-2">Points d'intégration possibles</h3>
                <ul className="list-disc list-inside space-y-1 text-gray-700">
                  <li>API REST pour connecter React avec vtiger</li>
                  <li>Migration progressive des modules vtiger vers React</li>
                  <li>Interface React moderne pour les données vtiger</li>
                  <li>Authentification unifiée entre les deux systèmes</li>
                </ul>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
};

export default FileStructure;
