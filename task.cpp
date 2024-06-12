#include <iostream>
#include <future>
#include <chrono>
#include <thread>
#include <functional>
#include <random>

void execute(std::function<void(int)> t, int load)
{
    std::packaged_task<void(int)> task(t);

    auto future = task.get_future();

    std::cout << "task is starting..." << std::endl;

    std::thread worker_thread(std::move(task), load);

    std::cout << "Waiting for completion... " << std::endl;

    future.get();

    std::cout << "Task completed. " << std::endl;

    if(worker_thread.joinable())
        worker_thread.join();
}

int main()
{

    auto job = [](int workload) -> void
    {
        for (int i = workload; i > 0; --i)
        {
            std::random_device rd;
            std::mt19937 gen(rd());
            std::uniform_real_distribution<double> dis(0.5, 1.5);
            double sleepTime = dis(gen);
            std::this_thread::sleep_for(std::chrono::duration<double>(sleepTime));
            std::cout << "Completed step #" << i << '\n';
        }
    };

    const int steps = 10;
    execute(job, steps);

    return 0;
}