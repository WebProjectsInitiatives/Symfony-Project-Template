<?php

// ###########################################################################################################
// symfony-project-template - Windows - Git hooks - Launch of PHP-CS-FIXER to fixes your code        #
// @author: William Pinaud & Aurélien Tricard                                                 #
// ###########################################################################################################

$config = PhpCsFixer\Config::create();
$config->setRules(
    [
        '@Symfony' => true,
        'array_syntax' => ['syntax' => 'short'],
        'concat_space' => ['spacing' => 'one'],
        'phpdoc_var_without_name' => false,
    ]
);

return $config;
