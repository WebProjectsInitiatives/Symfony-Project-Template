<?php

namespace App\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class PostControllerTest extends WebTestCase
{
    public function testShowPost()
    {
        $client = static::createClient();

        $crawler = $client->request('GET', '/');

        $this->assertSelectorTextContains('html h1', 'Hello World! ✅');

        $this->assertEquals(200, $client->getResponse()->getStatusCode());
    }
}
