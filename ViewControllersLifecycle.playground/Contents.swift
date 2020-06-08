/*: # View Controllers
## Ciclo de vida de um UIViewController!
### Observando como tudo acontece

Antes de mais nada, aqui teremos dois view controllers, um que será definido como do tipo FirstViewController e outro como SecondViewController.
A interação entre eles será bem simples, primeiro iremos criar um view controller do tipo FirstViewController que irá ser exibido. E após sua completa exibição, iremos instanciar um outra view controller do tipo SecondViewController e exibi-lo.
 
*P.s.: Desativar a renderização de documentação pode facilitar a leitura em alguns pontos.*
 
------------------
## Vamos começar:
*/

import UIKit
import PlaygroundSupport

class FirstViewController: UIViewController {
    
/*: O primeiro método que iremos observar é o `loadView()`. É ele que o View Controller chama quando sua propriedade `.view` é solicitada mas ainda é nula. Este método serve exatamente para carregar ou criar uma view e a atribui à propriedade `.view` do View Controller.
     
Segundo a documentação da Apple, você nunca deverá chamar esse método diretamente. Além disso, se você está utilizando o Interface Builder para criar suas views e inicializar o view controller, você não deve realizar o `override` desse método.
     
Você pode realizar o `override` desse método apenas quando você for criar suas views manualmente. Se você optar por fazer isso, atribua a view raiz da sua hierarquia de views à propriedade `.view` do view controller. As views criadas por você devem ser instâncias exclusivas e não devem ser compartilhadas com nenhum outro objeto do view controller.
Atenção, a implementação personalizada desse método também não deve chamar o seu super.
*/
    override func loadView() {
        //: A gente pode verificar com a propriedade booleana `isViewLoaded` se a view do view controller está carregada na memória.
        print("- Método loadView() -")
        print("A view do VC foi carregada: \(self.isViewLoaded)")
        
        //: Como verificado, a view ainda não foi carregada. Vamo inicializar uma view e atribuí-la a propriedade `.view` do view controller.
        let viewNova = UIView()
        self.view = viewNova

        //: Agora vamos verificar novamente a view foi carregada.
        print("A view do VC foi carregada: \(self.isViewLoaded)")
        
        //: Sucesso! Mas será que a view já foi desenhada na tela? Vamos verificar a seguir:
        print("A view foi desenhada: \(!(self.view.bounds.isEmpty))\n")
    }
    
    
/*: O segundo método que iremos observar é o `viewDidLoad()`. Este método é chamado depois que o view controller carregou sua hierarquia de view na memória. Este método é chamado independentemente se a hierarquia de view foi carregada de um arquivo nib ou criada programaticamente com o método `loadView()`.
     
Você geralmente realiza o `override` desse método para executar uma inicialização adicional nas views carregadas. E diferente do `loadView()`, normalmente é uma boa idéia chamar o super para todas as demais funções que você realiza o `override` do UIViewController que não têm um valor de retorno. Já que o UIViewController pode realizar algumas configurações importantes e não chamá-lo não daria a chance de executar esse código.
*/
    override func viewDidLoad() {
        print("- Método viewDidLoad() -")
        super.viewDidLoad()
        
        //: Mas vamos lá, aqui eu tenho a garantia que a view já foi carregada e posso, por exemplo, alterar a cor do seu background. Assim:
        self.view.backgroundColor = .red
        
        //: Mas a view já foi desenhada? Vamos verificar:
        print("A view foi desenhada: \(!(self.view.bounds.isEmpty))")
        
        //: Epa, não. Nesse método, a view foi completamente carregada, mas ainda não foi desenhada. Tanto que se printarmos os detalhes da view, seu frame estará zerado. Verifique no print a seguir:
        print("A view desse view controller é: \(self.view!)\n")
    }
    
    
/*: O terceiro método que iremos observar é o `viewWillAppear()`. Esse método é chamado antes que a view do view controller esteja prestes a ser adicionada a uma hierarquia de view e antes também de que qualquer animação seja configurada para desenhar a view.

Você pode realizar o `override` desse método para executar tarefas personalizadas associadas à exibição da view. Por exemplo, você pode usar esse método para alterar a orientação ou o estilo da barra de status, para coordenar com a orientação ou o estilo da view que está sendo apresentada. Mas lembre, se você realizar o `override` esse método, você deverá chamar seu super em algum momento da sua implementação.
*/
    override func viewWillAppear(_ animated: Bool) {
        print("- Método viewWillAppear(_:) -")
        super.viewWillAppear(animated)
        
        //: Nesse método, a view já foi desenhada, logo o seu frame já não está mais zerado e podemos identificar nos prints abaixo:
        print("A view foi desenhada: \(!(self.view.bounds.isEmpty))")
        print("A view desse view controller é: \(self.view!)")
        
        //: Mas atenção, a view ainda não está sendo exibida. Tanto que podemos confirmar com o print abaixo:
        print("A view está sendo exibida: \(self.view.window != nil)\n")
        
    }

    
/*: O quarto método que iremos observar é o `viewDidAppear()`. Esse método é chamado depois que a view do view controller foi adicionada a uma hierarquia de view e também exibida.

Você pode realizar o `override` desse método para executar tarefas adicionais associadas à apresentação da view. E não esqueça que deverá chamar o super em algum momento da sua implementação.
*/
    override func viewDidAppear(_ animated: Bool) {
        print("- Método viewDidAppear(_:) -")
        super.viewDidAppear(animated)
        
        //: Quando esse método é chamado, a view já está sendo apresentada na tela. Tanto que podemos confirmar com os prints abaixo:
        print("A view foi desenhada: \(!(self.view.bounds.isEmpty))")
        print("A view desse view controller é: \(self.view!)")
        print("A view está sendo exibida: \(self.view.window != nil)\n")
        
        //: E agora, vamos inicializar o SecondViewController, alterando sua apresentação para `.fullScreen`:
        let sndVc = SecondViewController()
        sndVc.modalPresentationStyle = .fullScreen
        
        //: Até aqui, o `sndVc`ainda não foi apresentado na tela e nem sua view foi carregada, apenas o view controller foi instanciado. Tanto que podemos verificar com o print abaixo:
        print("A view do sndVc foi carregada: \(sndVc.isViewLoaded)\n")
        
        //: Agora, vamos apresentá-lo:
        self.present(sndVc, animated: true, completion: nil)
        
        //: E aqui, podemos verificar que a view do sndVc foi carregada, mas ainda não foi apresentada:
        print("A view do sndVc foi carregada: \(sndVc.isViewLoaded)")
        print("A view do sndVc foi desenhada: \(!(sndVc.view.bounds.isEmpty))\n")
    }
    
    
/*: O quinto método que iremos observar é o `viewWillDisappear()`. Este método é chamado em resposta a uma view que está sendo removida de uma hierarquia de views. Esse método é chamado antes que a view seja realmente removida e antes que qualquer animação seja configurada.

Você pode realizar o `override` desse método para usá-lo como confirmação de modificações, renunciar ao status de first responder da view ou executar outras tarefas relevantes. Por exemplo, você pode usar esse método para reverter as alterações na orientação ou no estilo da barra de status que foram feitas no método `viewDidAppear (_ :)` quando a view foi apresentada pela primeira vez. E se você realizar o `override` desse método, você deverá chamar o super em algum momento da sua implementação.
*/
    override func viewWillDisappear(_ animated: Bool) {
        print("- Método viewWillDisappear(_:) -")
        super.viewWillDisappear(animated)
        
        //: Quando esse método é chamado, a view vai ser removida, mas ainda está sendo apresentada na tela. Tanto que podemos confirmar com os prints abaixo:
        print("A view foi desenhada: \(!(self.view.bounds.isEmpty))")
        print("A view desse view controller é: \(self.view!)")
        print("A view ainda está sendo exibida: \(self.view.window != nil)\n")
    }
    
    
/*: O sexto e último método que iremos observar é o `viewDidDisappear()`. Este método é chamado para notifica o view controller que sua view foi removida da hierarquia de views.

Você pode realizar o `override` desse método para executar tarefas adicionais associadas ao descartar ou ocultar a view. Mas novamente, se você realizar o `override` desse método, você deverá chamar o super em algum momento da sua implementação.
*/

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("- Método viewDidDisappear(_:) -")
        
        //: Aqui podemos verificar que a view existe, mas já não apresentada porque foi removida da hierarquia de views:
        print("A view desse view controller existe na memória: \(self.isViewLoaded)")
        print("A view está sendo exibida: \(self.view.window != nil)\n")
    }
}

class SecondViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .blue
        self.view = view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = FirstViewController()
