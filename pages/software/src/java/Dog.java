public class Dog{
    String breed;
    int age;
    String color;
    String name;

    static int count=0;

    Dog(String DogName)
    {
        name=DogName;
        System.out.println("we have "+(++count)+"dogs");
    }

    void barking(){
        System.out.println(name+" barking");
    }
    void hungry(){
        System.out.println(name+" hungry");
    }
    void sleeping(){
        System.out.println(name+" sleeping");
    }
 
}