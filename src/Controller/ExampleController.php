<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;

/**
 * Class ExampleController
 *
 * @package App\Controller
 */
class ExampleController extends AbstractController
{
    /**
     * @Route("/", name="Hello")
     */
    public function index()
    {
        return $this->render('example/index.html.twig', [
            'controller_name' => 'ExampleController',
        ]);
    }
}
